plugins {
    id("java")
    antlr
}

group = "org.example"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.jetbrains:annotations:24.0.0")
    antlr("org.antlr:antlr4:4.12.0")
    testImplementation("org.junit.jupiter:junit-jupiter-api:5.9.2")
    testRuntimeOnly("org.junit.jupiter:junit-jupiter-engine:5.9.2")
}
java {
    sourceCompatibility = JavaVersion.VERSION_14
    targetCompatibility = JavaVersion.VERSION_14
}

tasks {
    generateGrammarSource {
        maxHeapSize = "256m"
        arguments = arguments + listOf("-visitor", "-long-messages")
    }

    getByName<Test>("test") {
        useJUnitPlatform()
    }
    compileJava {
        dependsOn("generateGrammarSource")
    }
    compileTestJava {
        dependsOn("generateGrammarSource")
    }
}