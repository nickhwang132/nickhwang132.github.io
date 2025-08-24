---
permalink: /
title: "Biography"
author_profile: true
redirect_from: 
  - /about/
  - /about.html
---

<p style="text-indent: 2em; text-align: justify;">
I am an <strong>assistant professor</strong> in the <strong>School of Integrated Circuits at Peking University</strong>. My research interests include <strong>emerging computing based on emerging devices</strong>, including the <strong>design and fabrication of emerging devices</strong>, the <strong>circuit and architecture design of RRAM-based CIM chips</strong>, and <strong>neuromorphic computing</strong>. I have authored <strong>over 100 scientific publications</strong> in leading international journals and conferences, such as <strong>Nature Electronics</strong>, <strong>Nature Communications</strong>, <strong>Science Advances</strong>, <strong>Advanced Materials</strong>, <strong>IEEE-IEDM</strong>, <strong>DAC</strong>, <strong>IEEE-TCAS</strong>, and <strong>IEEE-EDL</strong>. I am a recipient of the <strong>Excellent Young Scholars (NSFC 2020)</strong>, the <strong>Second Prize of Natural Science Award (Ministry of Education 2019)</strong>, and <strong>PhD Student Fellowship (IEEE EDS 2014)</strong>.
</p>

<p style="text-indent: 2em; text-align: justify;">
I am always looking for <strong>motivated undergraduate and graduate students</strong> with backgrounds in <strong>microelectronics</strong>, <strong>integrated circuits</strong>, <strong>computer science</strong>, <strong>electrical engineering</strong>, <strong>physics</strong>, or related areas working on research fields of:
</p>

1. **RRAM-based CIM chips and systems** for neural networks.
2. **Emerging devices and architectures** for data sensing, computing, and storage.
3. **Memristor-based neuromorphic computing**.
4. **Auto design tools** for emerging computing systems.

**Opening positions available: Ph.D., Post Doc, Master**

News
======
<style>
.carousel-container {
    position: relative;
    max-width: 800px;
    margin: 20px auto;
    overflow: hidden;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
}

.carousel-slides {
    display: flex;
    transition: transform 0.5s ease-in-out;
}

.carousel-slide {
    min-width: 100%;
    text-align: center;
    padding: 20px;
    background: #f9f9f9;
}

.carousel-slide img {
    max-width: 90%;
    height: auto;
    border-radius: 8px;
    margin-bottom: 10px;
}

.carousel-slide p {
    margin: 10px 0;
    font-size: 14px;
    color: #666;
}

.carousel-nav {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background: rgba(0,0,0,0.5);
    color: white;
    border: none;
    padding: 10px 15px;
    cursor: pointer;
    border-radius: 50%;
    font-size: 18px;
}

.carousel-nav:hover {
    background: rgba(0,0,0,0.7);
}

.carousel-prev {
    left: 10px;
}

.carousel-next {
    right: 10px;
}

.carousel-dots {
    text-align: center;
    padding: 20px 0;
}

.carousel-dot {
    height: 12px;
    width: 12px;
    margin: 0 5px;
    background-color: #bbb;
    border-radius: 50%;
    display: inline-block;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.carousel-dot.active,
.carousel-dot:hover {
    background-color: #717171;
}
</style>

<div class="carousel-container">
    <div class="carousel-slides" id="carouselSlides">
        <div class="carousel-slide">
            <img src="../images/news1.jpg" alt="2024 Graduation celebration"/>
            <p>Celebrating our 2024 research group graduation!</p>
        </div>
        <div class="carousel-slide">
            <img src="../images/news2.jpg" alt="IEDM presentation"/>
            <p>Yiyang Chen presenting at 2024 IEDM.</p>
        </div>
        <!-- Add more slides here as needed -->
        <div class="carousel-slide">
            <img src="../images/news3.jpg" alt="VLSI presentation"/>
            <p>Latest research activities in our lab.</p>
        </div>
    </div>
    
    <button class="carousel-nav carousel-prev" onclick="moveSlide(-1)">&#10094;</button>
    <button class="carousel-nav carousel-next" onclick="moveSlide(1)">&#10095;</button>
    
    <div class="carousel-dots">
        <span class="carousel-dot active" onclick="currentSlide(1)"></span>
        <span class="carousel-dot" onclick="currentSlide(2)"></span>
        <span class="carousel-dot" onclick="currentSlide(3)"></span>
    </div>
</div>

<script>
let slideIndex = 0;
const slides = document.getElementById('carouselSlides');
const totalSlides = document.querySelectorAll('.carousel-slide').length;
const dots = document.querySelectorAll('.carousel-dot');

function showSlide(index) {
    if (index >= totalSlides) slideIndex = 0;
    if (index < 0) slideIndex = totalSlides - 1;
    
    slides.style.transform = `translateX(-${slideIndex * 100}%)`;
    
    dots.forEach(dot => dot.classList.remove('active'));
    dots[slideIndex].classList.add('active');
}

function moveSlide(direction) {
    slideIndex += direction;
    showSlide(slideIndex);
}

function currentSlide(index) {
    slideIndex = index - 1;
    showSlide(slideIndex);
}

// Auto-slide functionality (optional)
setInterval(() => {
    slideIndex++;
    showSlide(slideIndex);
}, 5000);
</script>

* Jul. 2025: Congratulations to Haozhang Yang and Shiyue Song on their successful doctoral degree graduation from our research group! Wishing them great success in their future careers.
* Jun. 2025: Paper is accepted to VLSI Technology and Circuits. Congratulations to Nan Tang and all the collaborators and sponsors.
* Apr. 2025: Paper is accepted to IEEE Transactions on Computers. Congratulations to Lixia Han and all the collaborators and sponsors.
* Mar. 2025: Paper is accepted to Japanese Journal of Applied Physics. Congratulations to Zhuohua Tang and all the collaborators and sponsors.
* Mar. 2025: Paper is accepted to IEEE-EDTM. Congratulations to Ruiqi Chen and all the collaborators and sponsors.
* Feb. 2025: Paper is accepted to Science China Information Sciences. Congratulations to Lixia Han and all the collaborators and sponsors.
* Dec. 2024: Paper is accepted to IEEE-TCAS-I. Congratulations to Yang Feng and all the collaborators and sponsors.
* Sep. 2024: Paper is accepted to IEDM. Congratulations to Yiyang Chen and all the collaborators and sponsors.
* Sep. 2024: Paper is accepted to IEEE-TCAS-I. Congratulations to Ao Shi and all the collaborators and sponsors.
* Jul. 2024: Congratulations to Lixia Han, Guihai Yu, and Ruiyi Li on successfully graduating with their doctoral degrees from our research group! Best wishes for your future endeavors.
* May. 2024: Paper is accepted to IEEE-ISCAS. Congratulations to Ao Shi and all the collaborators and sponsors.
* Mar. 2024: Paper is accepted to DATE. Congratulations to Lixia Han and all the collaborators and sponsors.
* Feb. 2024: Paper is accepted to Science Advances. Congratulations to Ruiqi Chen and all the collaborators and sponsors.
* Feb. 2024: Paper is accepted to Nature Communications. Congratulations to Yulin Feng and all the collaborators and sponsors.
* Jan. 2024: Paper is accepted to TCAD. Congratulations to Lixia Han and all the collaborators and sponsors.
* Jan. 2024: Paper is accepted to IEEE-EDL. Congratulations to Yiyang Chen and all the collaborators and sponsors.
