var geometry = 
    /* color: #98ff00 */
    /* displayProperties: [
      {
        "type": "rectangle"
      }
    ] */
    ee.Geometry.Polygon(
        [[[10.391926026252207, 63.44669414372024],
          [10.391926026252207, 63.42911578837656],
          [10.437931275275645, 63.42911578837656],
          [10.437931275275645, 63.44669414372024]]], null, false);

Map.centerObject(geometry);

// Load the soil data
var soilData = ee.Image('OpenLandMap/SOL/SOL_TEXTURE-CLASS_USDA-TT_M/v02')
.clip(geometry)
.select('b0');

// Define the visualization parameters
var visParams = {
  min: 0,
  max: 12,
  palette: [
    'd5c36b', 'b96947', '9d3706', 'ae868f', 'f86714', '46d143',
    '368f20', '3e5a14', 'ffd557', 'fff72e', 'ff5a9d', 'ff005b'
  ]
};

// Add soil data to the map
Map.addLayer(soilData.select('b0'), visParams, 'at 0 cm depth');

var trondheim = ee.Geometry.Rectangle([10.3323, 63.367, 10.516613, 63.4585]);

// Clip the soil data to the extent of Trondheim
var soilClassification = soilData.clip(trondheim);
Map.addLayer(soilClassification, visParams, 'Soil Classification class Trondheim (USDA system)');

// Create a legend
var legend = ui.Panel({
  style: {
    position: 'bottom-left',
    padding: '8px 15px'
  }
});

// Create the legend title
var legendTitle = ui.Label({
  value: 'Soil TEXTURE Classes',
  style: {
    fontWeight: 'bold',
    fontSize: '18px',
    margin: '0 0 4px 0',
    padding: '0'
  }
});
// Add the legend title to the legend panel
legend.add(legendTitle);

// Create and add color palettes to the legend
var soilClasses = [
  'Clay',
  'Silty clay',
  'Sandy clay',
  'Silty clay loam',
  'Sandy clay loam',
  'Loam',
  'Silt loam',
  'Sandy loam',
  'Silt'
];

// Function to create a row with color and label
var makeRow = function (color, name) {
  var colorBox = ui.Label({
    style: {
      backgroundColor: color,
      padding: '8px',
      margin: '0 0 4px 0'
    }
  });

  var label = ui.Label({
    value: name,
    style: {
      margin: '0 0 4px 6px'
    }
  });

  return ui.Panel({
    widgets: [colorBox, label],
    layout: ui.Panel.Layout.Flow('horizontal')
  });
};

// Add the color palettes to the legend
for (var i = 0; i < soilClasses.length; i++) {
  legend.add(makeRow(visParams.palette[i], soilClasses[i]));
}

// Add the legend to the map
Map.add(legend);
