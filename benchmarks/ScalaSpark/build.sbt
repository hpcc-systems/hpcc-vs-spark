name := "Spark Benchmark"

version := "1.0"

scalaVersion := "2.11.6"

libraryDependencies ++= Seq(
        "net.sf.jopt-simple" % "jopt-simple" % "4.6",
        "org.scalatest" %% "scalatest" % "2.2.1" % "test",
        "com.google.guava" % "guava" % "14.0.1",
        "org.apache.spark" %% "spark-core" % "2.2.0" % "provided",
        "org.json4s" %% "json4s-native" % "3.2.9"
      )
