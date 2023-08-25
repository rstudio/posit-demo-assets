# demo-plumber-tableau-penguins

A demo of using [plumbertableau](https://rstudio.github.io/plumbertableau/index.html) to create APIs that Tableau can consume.

- Code: <https://github.com/SamEdwardes/demo-plumber-penguins>
- API Deployment: <https://colorado.rstudio.com/rsc/demo-plumber-tableau-penguins/>
- Tableau Deployment: <https://us-west-2b.online.tableau.com/#/site/rstudio/workbooks/472632?:origin=card_share_link>

![plumber-tableau](https://user-images.githubusercontent.com/18248949/176033992-aa2633a4-8a6d-4501-8cf7-7087f18dd1fc.gif)

## API Deployment

### Git-backed

After making any code changes run the following:

```r
renv::snapshot()
rsconnect::writeManifest("app")
```

Next, push your changes to git. RStudio Connect will then automatically redeploy the app.

### Programatic

You can also deploy the app using the rsconnect api:

```r
rsconnect::deployAPI(
  api = "app",
  appFiles = c("plumber.R"),
  appTitle = "Plumber Tableau Penguins"
)
```

## Tableau Deployment

After deploying the API follow the instructions from <https://rstudio.github.io/plumbertableau/articles/tableau-developer-guide.html> to deploy in Tableau. For example, you must consider Tableau to use Connect as an Analytics Extension:

![image (1)](https://user-images.githubusercontent.com/18248949/185973483-eedfff35-4976-47aa-b922-f56f9a4146bf.png)

## Calling the API from Tableau

Create a field named `Selected Dimension Value` that will allow users to change which field they want to identify outliers based on.

![selected-dim](https://user-images.githubusercontent.com/18248949/185947742-6c391142-8a11-4447-8502-3f8214de3bf6.png)

Create a field named `Is Outlier?` which calls the plumber API using the `SCRIPT_BOOL` function. For each row in the data this will return `TRUE` or `FALSE`. Values that are `TRUE` are outliers.

![is-outlier](https://user-images.githubusercontent.com/18248949/185947614-691ad77f-73cf-4f7e-87cd-a2607ad8b2a6.png)

Construct the scatter plot that colors each data point based on its outlier status.

![edit-tableau](https://user-images.githubusercontent.com/18248949/185947787-f29c8290-ca68-4d30-836c-f738daa9c2a6.png)
