# WEP performance as a function of exposure time

```{abstract}
In this technote we evaluate the performance of the Active Optics System Wavefront Estimation Pipeline on a series of defocal exposures taken with different exposure times. This is acheived by comparing the estimated optical state from the pipeline to a known injected optical state. We will also evaluate the performance of the "direct detection" pipeline used in the AOS when pointing information is not accurate enough to use the reference catalogs as we expect during the initial days of commissioning.
```

## Introduction

This technote will explore how the Active Optics System (AOS) Wavefront Estimation Pipeline (WEP) behaves as a function of exposure time. The WEP algorithms attempt to quantify the optical state of the telescope by looking at postage stamps of defocused stars. Looking at exposures with increasingly longer exposure times allows us to study the performance of the WEP estimation as we move from faint images where only the brightest stars are visible to longer exposures where saturation might become a problem or crowding can lead to issues from blending. These issues are problems at all times but with good pointing information and accurate reference catalogs we can carefully choose sources at the catalog generation step that are not too bright and are far enough away from other sources that may overlap. However, at the beginning of commissioning we will need to use a "direct detection" algorithm where we choose sources for the WEP with image detection algorithms. This dataset also provides a good testing ground for this technique as we expect it to become more difficult with more crowded fields and increasing the exposure time creates this effect on the same field for comparison.

Therefore we will present results for two main studies in this technote:

1. Understand the performance of the WEP estimation algorithms at different exposure times and identify any problems that arise when looking at very faint or very bright images.
2. Use the different exposure times of the same field to analyze the performance of direct detect catalog generation for the WEP in sparsely populated low-SNR fields as well as crowded fields with more blended sources.

## Simulation

We created a set of simulated ComCom images using [imSim](https://www.github.com/LSSTDESC/imsim). The initial optical state was the same as state #1 in the 100 optical states simulated for [WET-001](https://sitcomtn-104.lsst.io/). Using this inital optical state we generated a triplet of intra-focal, in-focus, and extra-focal images for a set of 7 different exposure times in the r-band: 10, 15, 20, 30, 45, 60, and 90 seconds.

| SeqNum | Exposure Time |
|--------|---------------|
| 1-3    | 10 sec        |
| 4-6    | 15 sec        |
| 7-9    | 20 sec        |
| 10-12  | 30 sec        |
| 13-15  | 45 sec        |
| 16-18  | 60 sec        |
| 19-21  | 90 sec        |

The field we chose was centered at (RA, Dec) = (14:06:22.298, -26:40:56.5017) at MJD = 60518.00189 (07/27/2024). The images have been ingested into the AOS butler found on the USDF at: `/sdf/group/rubin/repo/aos_imsim/`. In Figure 1 we show the raw images for detector 4 across the 7 different exposure times.


<figure>
  <img src="notebooks/figures/raw_det_4.png" alt="Detector 4 Raw"/>
  <figcaption>Figure 1: Raw simulated extra-focal images for detector 4 on LSST ComCam across 7 different exposure times.</figcaption>
</figure>

## Data processing

After ingesting the raw images we ran Instrument Signature Removal (ISR) on the data and saved them to the collection `WET-013` in the AOS butler. This way we have a shared set of post-ISR images we can use for processing in different ways. Figure 2 shows what the same exposures as the raws in Figure 1 look like after ISR.

<figure>
  <img src="notebooks/figures/post_isr_det_4.png" alt="Detector 4 Post-ISR"/>
  <figcaption>Figure 2: Simulated extra-focal images for detector 4 on LSST ComCam after Instrument Signature Removal.</figcaption>
</figure>

Now we were ready to run the WEP in two different ways: 1) Using the available Gaia DR2 reference catalog that was used to generate the simulations and is available in the butler. We use the exposure's WCS to translate (ra, dec) to pixel coordinates and identify single, unblended donuts based upon these reference catalogs with no reference to the pixel level data. 2) Using our "direct detection" algorithm that runs a convolution of a donut model across the image and identifies donuts as peaks in the convolved image. This works without any reference to the image's WCS and is something we expect to use early in commissioning as the pointing model will likely not be good enough to use the reference catalog method right away.

### Comparing Catalog Generation