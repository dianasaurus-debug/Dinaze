<template>
  <div>
    <div class="col-12 mt-3">
      <!-- Button trigger modal -->
      <div class="card">
        <div class="card-header border-0">
          <h3 class="card-title">Data Program</h3>
          <div class="card-tools">
            <button type="button" class="btn btn-primary" @click="newModal">
              <i class="fas fa-plus"></i> Add Program
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
                                <span v-if="props.column.field == 'action'">
                                     <a href="#" class="mr-2" @click="viewProgram(props.row)">
                                                                      <i class="fas fa-eye"></i>
                                                                  </a>
                                                                    <a href="#" class="mr-2" @click="editModal(props.row)">
                                                                      <i class="fas fa-user-edit"
                                                                         style="color : lightseagreen !important;"></i>
                                                                      </a>
                                    <a href="#" @click="deleteProgram(props.row.id)" :class="{ disabled : isDisabled(props.row)}">
                                        <i class="fas fa-trash" :class="{ disabledIcon : isDisabled(props.row)}"></i>
                                    </a>
                                </span>
              <span v-else>
                                  {{ props.formattedRow[props.column.field] }}
                                </span>
            </template>
          </vue-good-table>
        </div>
      </div>
      <!-- /.card -->
    </div>


    <!-- Modal -->
    <div class="modal fade" id="addNew" tabindex="-1" role="dialog"
         aria-labelledby="addNew" aria-hidden="true">
      <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title" id="exampleModalCenterTitle" v-if="editMode==false">Add Program</h5>
            <h5 class="modal-title" v-else>Edit Program</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <form @submit.prevent="editMode ? updateProgram() : createProgram()">
            <div class="modal-body">
              <div class="form-group">
                <label for="judul">Judul Program Wakaf Uang</label>
                <input name="judul" v-model="program.judul" id="judul" class="form-control"
                       placeholder="Masukkan Judul Program Wakaf Uang" type="text"
                       :class="{ 'is-invalid': submitted && $v.program.judul.$error }">
                <div v-if="submitted && $v.program.judul.$error" class="invalid-feedback">
                  <span v-if="!$v.program.judul.required">Judul Program is required</span>
                </div>
              </div> <!-- form-group// -->
              <div class="form-group">
                <label for="detailProgram">Kategori Program Wakaf Uang</label>
                <div id="detailProgram">
                  <div class="row mb-2">
                    <div class="col-12 input-group">
                      <div class="input-group-prepend">
                        <span class="input-group-text" style="color : cornflowerblue; font-weight: bold"> <i
                            class="fa fa-building"></i> </span>
                      </div>
                      <select class="form-control" v-model="program.kategori_id"
                              :class="{ 'is-invalid': submitted && $v.program.kategori_id.$error }">
                        <option value="" disabled selected>Jenis Program Wakaf Uang</option>
                        <option v-for="category in categories" v-bind:value="category.id" v-bind:key="category.id">
                          {{ category.nama }}
                        </option>
                      </select>
                      <div v-if="submitted && $v.program.kategori_id.$error" class="invalid-feedback">
                        <span v-if="!$v.program.kategori_id.required">Kategori Program is required</span>
                      </div>
                    </div>
                  </div>
                </div>
              </div> <!-- form-group// -->
              <div class="form-group">
                <label for="descProgram">Detail Program Wakaf Uang</label>
                <textarea class="form-control" id="descProgram" rows="3"
                          placeholder="Masukkan deskripsi program wakaf uang dengan jelas"
                          v-model="program.deskripsi"
                          :class="{ 'is-invalid': submitted && $v.program.deskripsi.$error }"></textarea>
                <div v-if="submitted && $v.program.deskripsi.$error" class="invalid-feedback">
                  <span v-if="!$v.program.deskripsi.required">Deskripsi Program is required</span>
                </div>
              </div> <!-- form-group// -->

              <div class="form-group">
                <label>Gambar Program Wakaf</label>
                <div class="imagePreviewWrapper" @click="selectImage">
                  <img id="diplay_img" v-bind:src="imagePreview" @click="selectImage" style="border-radius : 5px;max-height : 120px; max-width: 130px;" alt=""/>
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
</template>
<script>
import axios from 'axios'
import $ from 'jquery'
import swal from 'sweetalert2'
import moment from 'moment'
import { required } from 'vuelidate/lib/validators'
import authHeader from '../../../services/auth-header-admin.service'

const URL = 'https://wakaf.praditya.web.id'
export default {
  title: 'Program Wakaf',
  created() {
    this.getAllPrograms()
    this.getAllCategories()
    this.$on('AfterCreated', () => {
      this.getAllPrograms()
    })
  },
  data() {

    return {
      imagePreview: 'https://www.pikpng.com/pngl/b/74-745720_download-img-icon-png-clipart.png',
      program: {
        judul: '',
        gambar: '',
        deskripsi: '',
        kategori_id: '',
      },
      columns: [
        {
          label: 'id',
          field: 'id'
        },
        {
          label: 'Judul',
          field: 'judul'
        },
        {
          label: 'Kategori',
          field: 'kategori.nama'
        },
        {
          label: 'Dibuat Pada',
          field: 'created_at',
          type: 'date',
          dateInputFormat: 'yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'',
          dateOutputFormat: 'dd/MM/yyyy'
        },
        {
          label: 'Action',
          field: 'action'
        }
      ],
      editMode : false,
      rows: [],
      page: 1,
      per_page: 10,
      p: {},
      submitted: false,
      categories: []
    }
  },
  validations: {
    program: {
      judul: { required },
      gambar: { required },
      deskripsi: { required },
      kategori_id: { required },
    }
  },
  methods: {
    isDisabled (data){
      if(data.wakaf_abadi_terkumpul==0 && data.wakaf_berjangka_terkumpul){
        return false;
      } else if(data.wakaf_berjangka_terkumpul>0 || data.wakaf_berjangka_terkumpul>0){
        return true;
      }
    },
    formatDate(dm) {
      return moment(dm)
          .format('DD/MM/YYYY')
    },
    newModal() {
      this.submitted = false
      this.imagePreview = 'https://www.pikpng.com/pngl/b/74-745720_download-img-icon-png-clipart.png'
      this.program = {}
      this.editMode = false
      $('#addNew')
          .modal('show')
    },
    editModal(program){
      this.submitted = false
      this.imagePreview = URL + '/images/'+program.gambar;
      this.program = program;
      this.editMode = true
      $('#addNew')
          .modal('show')
    },
    selectImage() {
      this.$refs.fileInput.click()
    },
    pickFile() {
      let input = this.$refs.fileInput
      this.program.gambar = input.files[0]

      let reader = new FileReader()

      reader.addEventListener('load', function () {
        this.imagePreview = reader.result
      }.bind(this), false)

      if (this.program.gambar) {
        if (/\.(jpe?g|jpg|png|gif)$/i.test(this.program.gambar.name)) {

          console.log('here')
          reader.readAsDataURL(this.program.gambar)
        }
      }
    },
    createProgram() {
      this.submitted = true
      const formData = new FormData()
      this.$v.$touch()
      formData.append('judul', this.program.judul)
      formData.append('deskripsi', this.program.deskripsi)
      formData.append('kategori_id', this.program.kategori_id)
      formData.append('file', this.program.gambar)
      if (!this.$v.$invalid) {
        this.$Progress.start()
        axios.post(URL + '/api/admin/program-wakaf', formData, { headers: authHeader() })
            .then((res) => {
                  console.log(res)
                  this.$emit('AfterCreated')
                  $('#addNew')
                      .modal('hide')
                  swal.fire(
                      'Sukses!',
                      'Data Program sudah diadd',
                      'success'
                  )
                  this.$Progress.finish()
                }
            )
            .catch(err => {
              console.log(err)
              swal.fire(
                  'Gagal!',
                  'Pastikan anda mengisikan data dengan benar',
                  'error'
              )
              this.$Progress.fail()
            })
      }
    },
    updateProgram() {
      this.submitted = true
      const formData = new FormData()
      this.$v.$touch()
      formData.append('judul', this.program.judul)
      formData.append('deskripsi', this.program.deskripsi)
      formData.append('kategori_id', this.program.kategori_id)
      formData.append('file', this.program.gambar)
      if (!this.$v.$invalid) {
        this.$Progress.start()
        axios.put(URL + '/api/admin/program-wakaf/'+this.program.id, formData, { headers: authHeader() })
            .then((res) => {
                  console.log(res)
                  this.$emit('AfterCreated')
                  $('#addNew')
                      .modal('hide')
                  swal.fire(
                      'Sukses!',
                      'Data Program sudah diupdate',
                      'success'
                  )
                  this.$Progress.finish()
                }
            )
            .catch(err => {
              console.log(err)
              swal.fire(
                  'Gagal!',
                  'Pastikan anda mengisikan data dengan benar',
                  'error'
              )
              this.$Progress.fail()
            })
      }
    },
    sendProgram(program) {
      this.$store.dispatch('currentProgramAdmin/pickProgram', program)
    },
    getAllPrograms() {
      axios.get(URL + '/api/admin/program-wakaf/all', { headers: authHeader() })
          .then(function (response) {
            this.rows = response.data.data
            console.log(this.rows);
          }.bind(this))
    },
    getAllCategories() {
      axios.get(URL + '/api/admin/kategori/all', { headers: authHeader() })
          .then(function (response) {
            this.categories = response.data.data
          }.bind(this))
    },
    deleteProgram(id) {
      swal.fire({
        title: 'Anda yakin?',
        text: 'Tindakan ini tidak bisa dikembalikan!',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Iya, hapus saja!'
      })
          .then((result) => {
            if (result.isConfirmed) {
              axios.delete(URL + '/api/admin/program-wakaf/' + id, { headers: authHeader() })
                  .then(() => {
                    this.$emit('AfterCreated')
                    swal.fire(
                        'Deleted!',
                        'Data Program sudah dihapus',
                        'success'
                    )
                  }).catch(err => {
                swal.fire(
                    'Gagal!',
                    'Program Wakaf tidak bisa dihapus!',
                    'error'
                )
                this.$Progress.fail();
              })
            }
          })
    },
    viewProgram(program) {
      this.sendProgram(program)
      this.$router.push('/admin/program/detail')
    }
  }
}
</script>
<style scoped>
.imagePreviewWrapper {
  width: 200px;
  display: block;
  cursor: pointer;
  margin: 0 auto 30px;
  background-size: cover;
  background-position: center center;
}

.align-left {
  text-align: left;
  font-size: 20px;
  font-weight: bold;
}
.disabled {
  cursor: not-allowed;
  opacity: 0.5;
  text-decoration: none;
}
.notdisabledIcon {
  color : red !important;
}
.disabledIcon {
  color : red !important;
  opacity: 0.5;
}
</style>
