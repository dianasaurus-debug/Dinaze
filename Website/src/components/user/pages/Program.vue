<template>
  <div>
    <div class="container">
      <ProgramCarousel/>
    </div>
    <CategoryPart/>
    <ProgramList/>
  </div>

</template>
<script>
import ProgramCarousel from "@/components/user/pages/ProgramCarousel";
import CategoryPart from "@/components/user/pages/CategoryPart";
import ProgramList from "@/components/user/pages/ProgramList";
export default {
  title: 'Daftar Program',
  components: {
    ProgramCarousel,
    CategoryPart,
    ProgramList
  },
}
</script>
