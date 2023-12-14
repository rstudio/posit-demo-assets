Traveling Salesperson Planner app
================

<figure>
<img src="images/screenshot.png"
alt="“Traveling Salesperson Planner app”" />
<figcaption aria-hidden="true">“Traveling Salesperson Planner
app”</figcaption>
</figure>

The Traveling Salesperson Planner Shiny app demo lets you upload a file
of destinations and download an efficiently ordered itinerary.

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

1.  **Select a starting location**. Type in a city name followed by a
    state, or choose one from the drop down menu. This will be the
    location you will begin and end your journey at. The app recognizes
    312 major North American cities.

    <figure>
    <img src="images/select_location.png" alt="“Select location”" />
    <figcaption aria-hidden="true">“Select location”</figcaption>
    </figure>

2.  **Upload a .csv file of destinations** to visit. If you do not have
    a file, you can download one of the three suggested files and then
    upload it to the app.

    <figure>
    <img src="images/upload.png" alt="“Upload a file of destinations”" />
    <figcaption aria-hidden="true">“Upload a file of
    destinations”</figcaption>
    </figure>

    The file should contain a table that has a column named `latitude`
    and a column named `longitude`. Latitude, Lat, lat, Longitude, Long,
    and long are all acceptable spellings. Other columns are OK, but
    there should at least be a latitude and longitude column. If your
    table does not have these columns, the app will return this alert.

    <figure>
    <img src="images/alert.png" alt="“What the alert looks like”" />
    <figcaption aria-hidden="true">“What the alert looks like”</figcaption>
    </figure>

3.  **Select an algorithm.** There are multiple ways to solve the
    “Traveling Salesperson Problem.” The app will use R’s [TSP
    package](https://github.com/mhahsler/TSP)[^1] and whatever algorithm
    you select to order the destinations into a sensible itinerary.

    After you select an algorithm, the app will build an itinerary and
    display a Download Itinerary button.

    <figure>
    <img src="images/algorithm.png" alt="“Select an algorithm”" />
    <figcaption aria-hidden="true">“Select an algorithm”</figcaption>
    </figure>

4.  **Click Download Itinerary.** The app will download a new version of
    your file. This versions reorders the rows in your original file to
    reflect the order in which you should visit the destinations. It
    also appends a column named “visit order”.

    <figure>
    <img src="images/download.png" alt="“The Download Button”" />
    <figcaption aria-hidden="true">“The Download Button”</figcaption>
    </figure>

## Deployment

### Push Button

Open `app/app.R` and use the blue publish icon in the upper right corner of the IDE code pane.

### rsconnect package

You can also deploy using the rsconnect package:

```
rsconnect::deployApp(
  appDir = "app",
  appTitle = "Traveling Salesperson App"
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
