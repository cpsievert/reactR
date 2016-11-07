library(htmltools)
library(reactR)
library(pipeR)

# FormidableLabs has been working hard on Victory-Chart
#  let's try to use it with reactR

# not necessary to make an htmlDependency but more robust if we do
victory <- htmlDependency(
  name = "victory",
  version = "0.13.3",
  src = c(href = "https://unpkg.com/victory/dist"),
  script = "victory.js"
)

victory_core <- htmlDependency(
  name = "victory-core",
  version = "9.1.1",
  src = c(href = "https://unpkg.com/victory-core@9.1.1/dist"),
  script = "victory-core.js"
)

victory_chart <- htmlDependency(
  name = "victory-chart",
  version = "13.1.1",
  src = c(href = "https://unpkg.com/victory-chart@13.1.1/dist"),
  script = "victory-chart.js"
)

demo_script <- HTML(
'
const data = [
  {quarter: 1, earnings: 13000},
  {quarter: 2, earnings: 16500},
  {quarter: 3, earnings: 14250},
  {quarter: 4, earnings: 19000}
];


// need to change example using VictoryChart namespace
//   so we will add VictoryChart. to all the components
class App extends React.Component {
  render() {
    return (
      <VictoryChart.VictoryChart
        // adding the material theme provided with Victory
        theme={VictoryCore.VictoryTheme.material}
        domainPadding={20}
      >
        <VictoryCore.VictoryLabel
          y = "20"
          text = "Victory from R"
          style = {{"font-size" : "150%"}}
        />
        <VictoryChart.VictoryAxis
          tickValues={["Quarter 1", "Quarter 2", "Quarter 3", "Quarter 4"]}
        />
        <VictoryChart.VictoryAxis
          dependentAxis
          tickFormat={(x) => (`$${x / 1000}k`)}
        />
        <VictoryChart.VictoryBar
          data={data}
          x={"quarter"}
          y={"earnings"}
        />
      </VictoryChart.VictoryChart>
    )
  }
}

const app = document.getElementById("app");
ReactDOM.render(<App />, app);
'
)

tagList(
  tags$div(id = "app"),
  tags$script(
    HTML(
      babel_transform(demo_script)
    )
  )
) %>>%
  attachDependencies(
    list(
      html_dependency_react(),
      victory_core,
      victory_chart
    )
  ) %>>%
  browsable()