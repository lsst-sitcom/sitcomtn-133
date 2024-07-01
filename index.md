# WEP performance as a function of exposure time

```{abstract}
In this technote we evaluate the performance of the Active Optics System Wavefront Estimation Pipeline on a series of defocal exposures taken with different exposure times. This is acheived by comparing the estimated optical state from the pipeline to a known injected optical state. We will also evaluate the performance of the "direct detection" pipeline used in the AOS when pointing information is not accurate enough to use the reference catalogs as we expect during the initial days of commissioning.
```

## Introduction

This technote will explore how the Active Optics System (AOS) Wavefront Estimation Pipeline (WEP) behaves as a function of exposure time. The WEP algorithms attempt to quantify the optical state of the telescope by looking at postage stamps of defocused stars. Looking at exposures with increasingly longer exposure times allows us to study the performance of the WEP estimation as we move from faint images where only the brightest stars are visible to longer exposures where saturation might become a problem or crowding can lead to issues from blending. These issues are problems at all times but with good pointing information and accurate reference catalogs we can carefully choose sources at the catalog generation step that are not too bright and are far enough away from other sources that may overlap. However, at the beginning of commissioning we will need to use a "direct detection" algorithm where we choose sources for the WEP with image detection algorithms. This dataset also provides a good testing ground for this technique as we expect it to become more difficult with more crowded fields and increasing the exposure time creates this effect on the same field for comparison.

Therefore we will present results for two main studies in this technote:

1. Understand the performance of the WEP estimation algorithms at different exposure times and identify any problems that arise when looking at very faint or very bright images.
2. Use the different exposure times of the same field to analyze the performance of direct detect catalog generation for the WEP in sparsely populated low-SNR fields as well as crowded fields with more blended sources.

