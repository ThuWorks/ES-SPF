var geometry = 
    /* color: #98ff00 */
    /* shown: false */
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
var lan  = ee.ImageCollection("LANDSAT/LC08/C02/T1_L2")
.filterBounds(geometry)
.filterDate('2023-01-01','2023-10-01')
.filter(ee.Filter.lessThan('CLOUD_COVER',35))
.map(function(image){
  var scale = image.multiply(0.0000275).add(-0.2);
  var clip = scale.clip(geometry);
  var EC = clip.expression(
    '2 * G - 5 * (R + NIR)',{
      'G': clip.select('SR_B3'),
      'R': clip.select('SR_B4'),
      'NIR': clip.select('SR_B5'),
    }).abs();
    
    return EC
})
.mean();



// Define the visualization parameters
var vis = {min: 0.1, max: 4, palette: ['purple', 'blue', 'cyan', 'green', 'yellow', 'orange', 'red']};

Map.addLayer(lan,vis,'EC SOIL');


// Add legend
Map.add(legendGradient('EC soil', vis, 'bottom-left'));

// Function to create gradient legend
function legendGradient(title, visual, position) {
  // set position of panel
  var legend = ui.Panel({
    layout: ui.Panel.Layout.flow('vertical', true),
    style: {
      position: position,
      stretch: 'horizontal',
      maxWidth: '100px',
    }
  });
   
  // Create legend title
  var legendTitle = ui.Label({
    value: title,
    style: {
    fontWeight: 'bold',
    fontSize: '15px',
    textAlign: 'center',
    stretch: 'horizontal'
    }
  });
   
  // Add the title to the panel
  legend.add(legendTitle);
   
  // create the legend image
  var lon = ee.Image.pixelLonLat().select('latitude');
  var gradient = lon.multiply((visual.max-visual.min)/100.0).add(visual.min);
  var legendImage = gradient.visualize(visual);
   
  // create text on top of legend
  var max = ui.Label({
    value: visual.max,
    style: {textAlign: 'center', stretch: 'horizontal'}
  });
  legend.add(max);
   
  // create thumbnail from the image
  var thumbnail = ui.Thumbnail({
    image: legendImage,
    params: {bbox:'0,0,10,100', dimensions:'10x50'},
    style: {textAlign: 'center', stretch: 'horizontal', height: '150px'}
  });
   
  // add the thumbnail to the legend
  legend.add(thumbnail);
   
  // create text on bottom of legend
  var min = ui.Label({
    value: visual.min,
    style: {textAlign: 'center', stretch: 'horizontal'}
  });
  legend.add(min);
   
  return legend;
}