<template>
  <div>
    <b-carousel
        id="carousel-1"
        fade
        v-model="slide"
        :interval="4000"
        controls
        indicators
        background="#ababab"
        img-width="1024"
        img-height="480"
        style="text-shadow: 1px 1px 2px #333;"
        @sliding-start="onSlideStart"
        @sliding-end="onSlideEnd"
    >
      <!-- Text slides with image -->
      <b-carousel-slide
          :img-src="require('@/assets/images/programs_carousel/kalisa1.jpg')"
      ></b-carousel-slide>

      <!-- Slides with custom text -->
      <b-carousel-slide :img-src="require('@/assets/images/programs_carousel/kalisa2.jpg')">
      </b-carousel-slide>

      <!-- Slides with image only -->
      <b-carousel-slide :img-src="require('@/assets/images/programs_carousel/kalisa3.jpg')"></b-carousel-slide>

    </b-carousel>

<!--    <p class="mt-4">-->
<!--      Slide #: {{ slide }}<br>-->
<!--      Sliding: {{ sliding }}-->
<!--    </p>-->
  </div>
</template>

<script>
export default {
  data() {
    return {
      slide: 0,
      sliding: null
    }
  },
  methods: {
    onSlideStart() {
      this.sliding = true
    },
    onSlideEnd() {
      this.sliding = false
    }
  }
}
</script>
