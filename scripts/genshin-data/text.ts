import textMapCHS from "../../vendordata/GenshinData/TextMap/TextMapCHS.json";
import textMapEN from "../../vendordata/GenshinData/TextMap/TextMapEN.json";

import { snakeCase, trim, trimEnd } from "lodash";

export const chsText = (hash: number): string => {
  return (textMapCHS as any)[hash];
};

export const enText = (hash: number): string => {
  return (textMapEN as any)[hash];
};

export const process =
  (textProcesses: Array<(s: string) => string>) =>
  (s: string): string => {
    return textProcesses.reduce((s, p) => p(s), s);
  };

export const i18n = (hash: number, ...textProcesses: Array<(s: string) => string>) => ({
  CHS: process(textProcesses)(chsText(hash)),
  EN: process(textProcesses)(enText(hash)),
});

export const i18nForName = (hash: number, ...textProcesses: Array<(s: string) => string>) => {
  const i = i18n(hash, ...textProcesses);
  return {
    ...i,
    ID: snakeCase(i.EN),
  };
};

export const i18nList = (list: number[], ...textProcesses: Array<(s: string) => string>) => {
  return list.map((s) => i18n(s, ...textProcesses)).filter((s) => s.CHS);
};

export const cleanText = (t: string): string => {
  return t
    .replace(new RegExp(/<color=#[0-9A-F]+>([^<]+)<\/color>/, "g"), "$1")
    .replace(new RegExp(/<i>([^<]+)<\/i>/, "g"), "$1");
};

export const parseParam = (t: string, params: number[]): string => {
  const m = t.match(/({[^}]+})/g);

  if (!!m) {
    m.forEach((p) => {
      const pipe = p.slice(1, p.length - 1).split(":");

      let v: any;

      pipe.forEach((p) => {
        if (p.startsWith("param")) {
          const idx = parseInt(p.slice("param".length));
          v = params[idx - 1];
        } else {
          switch (p) {
            case "F":
              v = Math.round(v);
              break;
            case "F1":
              v = Math.round(v * 10) / 10;
              break;
            case "F2":
              v = Math.round(v * 100) / 100;
              break;
            case "I":
              v = Math.round(v);
              break;
            case "P":
              v = Math.round(v * 100) + "%";
              break;
            case "F1P":
              v = Math.round(v * 100 * 10) / 10 + "%";
              break;
          }
        }
      });

      t = t.replace(p, String(v));
    });
  }

  return t;
};

const paramRegExps = [
  /<color=#[0-9A-F]+>([^<]+)<\/color>/,
  /<i>([^<]+)<\/i>/,
  /([0-9./]+%)/,
  /([0-9.]+)点/,
  /([0-9.]+)秒/,
];

export const resolveParamNames = (s: string, params: number[], name: string): string[] => {
  const paramNames: string[] = [];

  const mayReplaceParam = (expect: string): string => {
    for (let i = 0; i < params.length; i++) {
      const v = params[i];

      if (expect.endsWith("%")) {
        if (expect == `${Math.round(v * 100)}%`) {
          return `{param${i + 1}:P}`;
        }
        if (expect == `${Math.round(v * 100 * 10) / 10}%`) {
          return `{param${i + 1}:F1P}`;
        }
      } else {
        if (expect == `${Math.round(v * 100) / 100}%`) {
          return `{param${i + 1}:F2}`;
        }
        if (expect == `${Math.round(v * 10) / 10}%`) {
          return `{param${i + 1}:F1}`;
        }
        if (expect == `${Math.round(v)}`) {
          return `{param${i + 1}:I}`;
        }
      }
    }
    return expect;
  };

  s.split(/[；。]/).forEach((p, j) => {
    if (p == "") {
      return;
    }

    let paramName = p;
    let expect = p;

    const m = paramName.match(new RegExp(paramRegExps.map((r) => `(${trim(String(r), "/")})`).join("|"), "g"));

    if (!!m) {
      m.forEach((matched) => {
        const param = paramRegExps.find((r) => r.test(matched))!.exec(matched)![1];

        if (param.startsWith("仅在以下平台生效")) {
          return;
        }

        if (param.endsWith("%")) {
          // 24/48/80% => 24%/48%/80%
          expect = p.replace(
            param,
            trimEnd(param, "%")
              .split("/")
              .map((v) => v + "%")
              .join("/"),
          );

          paramName = paramName.replace(
            matched,
            matched.replace(
              param,
              trimEnd(param, "%")
                .split("/")
                .map((v) => {
                  return mayReplaceParam(v + "%");
                })
                .join("/"),
            ),
          );
        } else {
          paramName = paramName.replace(
            matched,
            matched.replace(
              param,
              param
                .split("/")
                .map((v) => {
                  return mayReplaceParam(v);
                })
                .join("/"),
            ),
          );
        }
      });
    }

    paramNames.push(paramName);

    if (parseParam(paramName, params) !== expect) {
      console.log(`===${name}===`);
      console.log("expect: ", expect);
      console.log("actual: ", parseParam(paramName, params));
      console.log(paramNames, params);
    }
  });

  return paramNames.map((paramName) => {
    while (true) {
      const m = paramName.match(/<color=#[0-9A-F]+>([^<]+)<\/color>/);
      if (!!m) {
        paramName = paramName.replace(m[0], m[1]);
      } else {
        break;
      }
    }
    return paramName;
  });
};
