# Posit Team & R

Posit Connect is a publishing platform for the work your team creates in R and Python.

To add: 

- Quarto 
- Parallelization 
- Async 
- Load testing/ Profvis 
- Data access 
- Reticulated python

This repository contains examples of R content, including:

## Interactive apps

- [Shiny Penguins](./shiny-penguins/README.md)

## Web APIs

- [Plumber](./plumber-penguins/README.md)
- [Plumber Tableau Integration](./plumber-tableau-penguins/README.md)

## Documents

- [RMarkdown using Blastula for sending emails](./rmd-blastula/README.md)
- [RMarkdown](./rmd-penguins/README.md)
- [Connect Widgets](./connectwidgets-penguins/README.md)
- [RMarkdown Flexdashboard Parameterized Sales Dashboard](./rmd-flexdashboard-parameterized-sales/README.md)

## Pins

- [Pins](./pins-r-penguins)

## Other 

- [Job Launcher](./r-job-launcher)

## Getting Started

You can deploy examples from this repo to your Connect server [via git-backed deployment](https://docs.rstudio.com/connect/user/git-backed/), or clone the repository and deploy examples using [push-button publishing](https://docs.posit.co/connect/user/publishing/) or from their manifests with the [`rsconnect` CLI](https://docs.posit.co/connect/user/publishing-r/).

If you want to explore an example more closely before deploying it:

* Clone this repository
* Navigate the working directory to the desired example, for example with `setwd("./shiny-penguins")`
* Restore the needed packages from the renv lock file after setting your repository to the appropriate source

```r
options(repos = c(CRAN = "https://p3m.dev/cran/latest"))
renv::restore()
```

## Projects

### Bike share

The "mega" bike share demo:
-   To see all content on Connect filter on the tag [Bike Predict](https://colorado.posit.co/rsc/connect/#/content/listing?filter=min_role:viewer&filter=content_type:all&view_type=expanded&tags=111-tagtree:218)_
-   View the Connect Widgets Dashboard:
    -   [Solo View](https://colorado.rstudio.com/rsc/bike-share/)
    -   [Dashboard View](https://colorado.rstudio.com/rsc/connect/#/apps/3124a8f9-7d30-44b9-a49a-552db71b036e)
-   Source code: [https://github.com/sol-eng/bike_predict](https://github.com/sol-eng/bike_predict)

## Want to add an example? 

Awesome! The requirements are: 

1. Use [renv](https://rstudio.github.io/renv/articles/renv.html) so that the package versions are recorded 
2. Create the [manifest.json file](https://docs.posit.co/connect/user/git-backed/#creating-a-manifest-file-from-r) to support git-backed publishing

