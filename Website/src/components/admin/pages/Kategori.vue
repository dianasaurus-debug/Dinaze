<template>
  <div>
    <div class="col-12 mt-3">
      <!-- Button trigger modal -->
      <div class="card">
        <div class="card-header border-0">
          <h3 class="card-title">Data Kategori</h3>
          <div class="card-tools">
            <!-- Button trigger modal -->
            <button type="button" class="btn btn-primary" @click="newModal">
              <i class="fas fa-plus"></i> Add Category
            </button>
          </div>
        </div>
        <div class="card-body table-responsive p-0">
          <vue-good-table
              :columns="columns"
              :rows="rows"
              :search-options="{ enabled: true }"
              :pagination-options="{enabled: true}"
              :line-numbers="true">
            <template slot="table-row" slot-scope="props">
                                            <span v-if="props.column.field == 'gambar'">
                                              <img :src="'https://wakaf.praditya.web.id/images/'+props.row.gambar" width="100px">
                                            </span>
              <span v-else-if="props.column.field == 'action'">
                                              <a href="#" class="mr-2" @click="viewKategori(props.row.id)">
                                                <i class="fas fa-eye"></i>
                                              </a>
                                                <a href="#" class="mr-2" @click="editModal(props.row)">
                                                <i class="fas fa-user-edit" style="color : lightseagreen !important;"></i>
                                                </a>
                                                <a href="#" @click="deleteCategory(props.row.id)">
                                                    <i class="fas fa-trash" style="color : red !important;"></i>
                                                </a>
                                            </span>
              <span v-else>
                                              {{ props.formattedRow[props.column.field] }}
                                            </span>
            </template>
          </vue-good-table>
        </div>
      </div>

      <!-- Modal -->
      <div class="modal fade" id="addNew" tabindex="-1" role="dialog" aria-labelledby="addNew" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h5 class="modal-title" id="exampleModalCenterTitle" v-if="editMode==false">Add Kategori</h5>
              <h5 class="modal-title" v-else>Edit Kategori</h5>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <form @submit.prevent="editMode ? updateKategori() : createCategory()">
              <div class="modal-body">
                <div class="form-group">
                  <label for="judul">Nama Kategori Wakaf Uang</label>
                  <input name="judul" v-model="kategori.nama" id="judul" class="form-control" placeholder="Masukkan Kategori Program Wakaf Uang" type="text" :class="{ 'is-invalid': submitted && $v.kategori.nama.$error }">
                  <div v-if="submitted && $v.kategori.nama.$error" class="invalid-feedback">
                    <span v-if="!$v.kategori.nama.required">Nama Kategori is required</span>
                  </div>
                </div> <!-- form-group// -->
                <div class="form-group">
                  <label for="descProgram">Deskripsi Kategori Wakaf Uang</label>
                  <textarea class="form-control" id="descProgram" rows="3" placeholder="Masukkan deskripsi program wakaf uang dengan jelas"  v-model="kategori.deskripsi" :class="{ 'is-invalid': submitted && $v.kategori.deskripsi.$error }"></textarea>
                  <div v-if="submitted && $v.kategori.deskripsi.$error" class="invalid-feedback">
                    <span v-if="!$v.kategori.deskripsi.required">Deskripsi is required</span>
                  </div>
                </div> <!-- form-group// -->

                <div class="form-group">
                  <div
                      class="imagePreviewWrapper"
                      :style="{ 'background-image': `url(${imagePreview})` }"
                      @click="selectImage">
                  </div>

                  <input
                      ref="fileInput"
                      type="file"
                      @input="pickFile">
                </div> <!-- form-group// -->
              </div>
              <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button class="btn btn-primary" type="submit">Save changes</button>
              </div>
            </form>
          </div>
        </div>
      </div>

    </div>
  </div>
</template>
<script>

import axios from 'axios';
import {required} from "vuelidate/lib/validators";
import swal from 'sweetalert2'
import $ from 'jquery'
const URL = 'https://wakaf.praditya.web.id'
import authHeader from '../../../services/auth-header-admin.service';


export default {
  title: 'Kategori Program Wakaf',
  created() {
    this.getAllCategories();
    this.$on('AfterCreated', () => {
      this.getAllCategories();
    })
  },
  data() {
    return {
      imagePreview: 'https://www.pikpng.com/pngl/b/74-745720_download-img-icon-png-clipart.png',
      kategori : {
        nama :'',
        gambar : '',
        deskripsi : ''
      },
      submitted : false,
      columns: [

        {label: 'id', field: 'id'},
        {label: 'Nama Kategori', field: 'nama'},
        {label: 'Gambar', field: 'gambar'},
        {
          label: 'Created At',
          field: 'created_at',
          type: 'date',
          dateInputFormat: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'",
          dateOutputFormat: 'dd/MM/yyyy'
        },
        {label: 'Action', field: 'action'},

      ],
      rows: [],
      page: 1,
      per_page: 10,
      category : {},
      editMode : false,
    }
  },
  validations: {
    kategori: {
      nama: {required},
      deskripsi: {required},
    }
  },
  methods : {
    newModal() {
      this.imagePreview = 'https://www.pikpng.com/pngl/b/74-745720_download-img-icon-png-clipart.png';
      this.kategori = {};
      this.editMode = false;
      $("#addNew").modal('show');
    },
    editModal(kategori){
      this.submitted = false
      this.imagePreview = `${URL}/images/`+kategori.gambar;
      this.kategori = kategori;
      this.editMode = true;
      $('#addNew')
          .modal('show')
    },
    selectImage () {
      this.$refs.fileInput.click()
    },
    pickFile () {
      let input = this.$refs.fileInput
      this.kategori.gambar = input.files[0];

      let reader  = new FileReader();

      reader.addEventListener("load", function () {
        this.imagePreview = reader.result;
      }.bind(this), false);

      if( this.kategori.gambar ){
        if ( /\.(jpe?g|jpg|png|gif)$/i.test( this.kategori.gambar.name ) ) {

          console.log("here");
          reader.readAsDataURL( this.kategori.gambar );
        }
      }
    },
    createCategory(){
      this.submitted = true;
      const formData = new FormData();
      console.log(this.kategori.gambar);
      formData.append('nama', this.kategori.nama);
      formData.append('file', this.kategori.gambar);
      formData.append('deskripsi', this.kategori.deskripsi);
      this.$Progress.start();
      axios.post(URL + '/api/admin/kategori/', formData, {headers: authHeader()}).then((res) => {
        console.log(res)
        this.$emit('AfterCreated');
        $("#addNew").modal('hide');
        swal.fire(
            'Sukses!',
            'Data kategori sudah diadd',
            'success'
        )
        this.$Progress.finish();
      }).catch(err => {
        console.log(err);
        swal.fire(
            'Gagal!',
            'Pastikan anda mengisikan data dengan benar',
            'error'
        )
        this.$Progress.fail();
      })
    },
    updateKategori(){
      this.submitted = true;
      const formData = new FormData();

      formData.append('nama_kategori', this.kategori.nama);
      formData.append('file', this.kategori.gambar);
      formData.append('deskripsi', this.kategori.deskripsi);
      this.$Progress.start();
      axios.put(URL + '/api/admin/kategori/'+this.kategori.id, formData, {headers: authHeader()}).then((res) => {
        console.log(res)
        this.$emit('AfterCreated');
        $("#addNew").modal('hide');
        swal.fire(
            'Sukses!',
            'Data kategori sudah diupdate',
            'success'
        )
        this.$Progress.finish();
      }).catch(err => {
        console.log(err);
        swal.fire(
            'Gagal!',
            'Pastikan anda mengisikan data dengan benar',
            'error'
        )
        this.$Progress.fail();
      })
    },
    getAllCategories(){
      axios.get(URL+ '/api/admin/kategori/all', {headers: authHeader()}).then(function(response){
        this.rows = response.data.data;
      }.bind(this));
    },
    deleteCategory(id){
      swal.fire({
        title: 'Anda yakin?',
        text: "Tindakan ini tidak bisa menghapus data program yang mengacu padanya!",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Iya, hapus saja!'
      }).then((result) => {
        if (result.isConfirmed) {
          axios.delete(URL+'/api/admin/kategori/' + id, {headers: authHeader()}).then(() => {
            this.$emit('AfterCreated');
            swal.fire(
                'Deleted!',
                'Data Kategori sudah dihapus',
                'success'
            )
          }).catch(err => {
            swal.fire(
                'Gagal!',
                'Kategori tidak bisa dihapus!',
                'error'
            )
            this.$Progress.fail();
          });
        }
      })
    },
    viewKategori(id){
      axios.get(URL+ '/api/admin/kategori/view/'+id, {headers: authHeader()}).then(function(response){
        this.category = response.data.data;
        swal.fire({
          title: `<strong>${this.category.nama}</strong>`,
          imageUrl: `http://localhost:4000/images/${this.category.gambar}`,
          html:
              `<p>${this.category.deskripsi}</p>`,
          showCloseButton: true,
        })
      }.bind(this));
    }
  }
}
</script>
<style scoped>
.imagePreviewWrapper {
  width: 150px;
  height: 150px;
  display: block;
  cursor: pointer;
  margin: 0 auto 30px;
  background-size: cover;
  background-position: center center;
}
</style>
