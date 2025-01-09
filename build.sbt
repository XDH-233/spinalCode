name := "spinalCode"

scalaVersion := "2.12.20"

val spinalVersion    = "1.10.2"
val spinalCore       = "com.github.spinalhdl" %% "spinalhdl-core" % spinalVersion
val spinalLib        = "com.github.spinalhdl" %% "spinalhdl-lib" % spinalVersion
val spinalIdslPlugin = compilerPlugin("com.github.spinalhdl" %% "spinalhdl-idsl-plugin" % spinalVersion)
libraryDependencies ++= Seq(spinalCore, spinalLib, spinalIdslPlugin)

libraryDependencies += "org.scalactic" %% "scalactic" % "3.2.9" % Test
// libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.9"
libraryDependencies += "org.scalatest" %% "scalatest" % "3.2.10"


libraryDependencies += "org.apache.poi" % "poi" % "4.1.2"
libraryDependencies += "org.apache.poi" % "poi-ooxml" % "4.1.2"
libraryDependencies += "org.jfree" % "jfreechart" % "1.5.3"
dependencyOverrides += "org.scala-lang.modules" %% "scala-xml" % "1.3.0"

libraryDependencies += "log4j" % "log4j" % "1.2.17"



fork := true
