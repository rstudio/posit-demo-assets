Free Trial by Customer Segment app
================

<figure>
<img src="images/screenshot.png"
alt="“Free Trial by Customer Segment app”" />
<figcaption aria-hidden="true">“Free Trial by Customer Segment
app”</figcaption>
</figure>

The Free Trial by Customer Segment app compares the effectiveness of two
types of free trials at converting users into customers at a fictitious
company:

- Free Trial A lasts 30 days
- Free Trial B lasts 100 days

The app allows decisions makers to explore various segments of customer
data in real time, so they can quickly decide which free trial to adopt
and under which circumstances. When a decision maker wants to look at
the data in a new way, they don’t need to wait to meet with their
Analysts, they simply click a button.

## Usage

Setup the `renv` environment:

```r
renv::activate()
renv::restore()
```

To run the app either open `app/app.R` and click the "Run App" button at the top of the IDE code pane or use:

```r
shiny::runApp("app")
```

### Using the app

1.  **Select a combination of industries to view**. Type in one or more
    industry names, or select industries from the drop down menu. The
    app will adjust to focus only on results for customers from these
    industries. Leave this field blank to focus on all industries.

    <figure>
    <img src="images/select_industry.png" alt="“Select industries”" />
    <figcaption aria-hidden="true">“Select industries”</figcaption>
    </figure>

2.  **Select a propensity to buy**. DemoCo, the fictitious company who
    sponsored the app, divides potential customers into three
    categories:

    1.  Good - likely to buy
    2.  Average - neither likely nor unlikely to buy
    3.  Poor - unlikely to buy

    The app will adjust to focus on results for the selected category or
    categories of potential customers. Leave this field blank to focus
    on all customers.

    <figure>
    <img src="images/select_propensity.png"
    alt="“Select a propensity to buy”" />
    <figcaption aria-hidden="true">“Select a propensity to buy”</figcaption>
    </figure>

3.  **Select a contract type.** The app will adjust to focus on results
    for customers who sign an annual contract, or a monthly contract.
    Leave this field blank to include both types of contracts.

    <figure>
    <img src="images/select_contract.png" alt="“Select a contract type”" />
    <figcaption aria-hidden="true">“Select a contract type”</figcaption>
    </figure>

## Deployment

### Push Button

Open `app/app.R` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployApp(
  appDir = "app",
  appTitle = "Evaluation Analysis App"
)
```

### Git-backed

Update the code, and then run:

```r
rsconnect::writeManifest("app")
```

Commit the new `manifest.json` file to the git repo along with the code.

## Resources

[Posit Connect User Guide: Shiny](https://docs.posit.co/connect/user/shiny/)
