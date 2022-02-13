import { mkdirSync, copyFileSync, rmSync, writeFileSync, existsSync, readFileSync } from "fs";
import outputMeta from "../build/app/outputs/apk/release/output-metadata.json";
import { join } from "path";
import { execSync } from "child_process";
import { readdirSync } from "fs";

const channel = process.env.CHANNEL;

if (!channel) {
  throw new Error("missing env var $CHANNEL");
}

const repo = "git@gitee.com:morlay/genshintools-release.git";
const publicPath = `https://ghproxy.com/https://raw.githubusercontent.com/morlay/genshintools/release-${channel}`;

const latest = {
  packageName: outputMeta.applicationId,
  version: outputMeta.elements[0].versionName,
  buildNumber: `${outputMeta.elements[0].versionCode}`,
  downloadURL: `${publicPath}/android/${outputMeta.elements[0].outputFile}`,
  description: String(readFileSync("RELEASE_NOTES.md")),
};

const apkReleaseDir = "./build/app/outputs/apk/release";
const distributeDir = "./build/.distribute";

if (existsSync(distributeDir)) {
  rmSync(distributeDir, { recursive: true });
}

const androidDir = join(distributeDir, "android");

mkdirSync(androidDir, { recursive: true });
writeFileSync(join(androidDir, "latest.json"), JSON.stringify(latest, null, 2));
copyFileSync(
  join(apkReleaseDir, outputMeta.elements[0].outputFile),
  join(androidDir, outputMeta.elements[0].outputFile),
);
