// Load and transform XML data
document.addEventListener("DOMContentLoaded", () => {
  fetch("data/data.xml")
    .then((response) => response.text())
    .then((xmlData) => {
      const parser = new DOMParser();
      const xmlDoc = parser.parseFromString(xmlData, "text/xml");

      // Load XSLT
      fetch("xslt/chart.xslt")
        .then((response) => response.text())
        .then((xsltData) => {
          const xsltDoc = parser.parseFromString(xsltData, "text/xml");
          const xsltProcessor = new XSLTProcessor();
          xsltProcessor.importStylesheet(xsltDoc);

          // Transform XML to SVG
          const resultDoc = xsltProcessor.transformToDocument(xmlDoc);
          const svg = resultDoc.documentElement;
          svg.setAttribute("class", "chart-svg");

          // Inject SVG into HTML
          document.getElementById("chart-container").appendChild(svg);

          // Add interactivity
          addBarHoverEffect();
        });
    });
});

// Add hover effect to bars
function addBarHoverEffect() {
  document.querySelectorAll(".bar").forEach((bar) => {
    bar.addEventListener("mouseover", () => {
      bar.style.fill = "#45a049";
    });
    bar.addEventListener("mouseout", () => {
      bar.style.fill = "#4CAF50";
    });
  });
}
