import { snakeCase, reduce } from "lodash-es";
import { mkdirSync, writeFileSync } from "fs";
import { dirname } from "path";

const textMapCHS = (await import("../../vendordata/GenshinData/TextMap/TextMapCHS.json")).default;
const textMapEN = (await import("../../vendordata/GenshinData/TextMap/TextMapEN.json")).default;

const chsText = (hash: number): string => {
  return (textMapCHS as any)[hash];
};

const enText = (hash: number): string => {
  return (textMapEN as any)[hash];
};

const process =
  (textProcesses: Array<(s: string) => string>) =>
  (s: string): string => {
    return textProcesses.reduce((s, p) => p(s), s);
  };

export const i18n = (hash: number, ...textProcesses: Array<(s: string) => string>) => ({
  CHS: process(textProcesses)(chsText(hash)),
  EN: process(textProcesses)(enText(hash)),
});

export const i18nWithID = (hash: number, ...textProcesses: Array<(s: string) => string>) => {
  const i = i18n(hash, ...textProcesses);
  return {
    ...i,
    ID: snakeCase(i.EN),
  };
};

export const cleanText = (t: string): string => {
  return t
    .replace(new RegExp(/<color=#[0-9A-F]+>([^<]+)<\/color>/, "g"), "$1")
    .replace(new RegExp(/<i>([^<]+)<\/i>/, "g"), "$1");
};

export const groupOne = <Input, Output>(list: Input[], convert: (i: Input) => null | Output, idKey: keyof Input) => {
  return list.reduce((state, item) => {
    const t = convert(item);
    if (!t) {
      return state;
    }
    return {
      ...state,
      [(item as any)[idKey]]: t,
    };
  }, {} as { [k: number]: Output });
};

export const groupMulti = <Input, Output>(list: Input[], convert: (i: Input) => null | Output, idKey: keyof Input) => {
  return list.reduce((state, item) => {
    const t = convert(item);

    if (!t) {
      return state;
    }

    return {
      ...state,
      [(item as any)[idKey]]: [...(state[(item as any)[idKey]] || []), t],
    };
  }, {} as { [k: number]: Output[] });
};

export const writeJSONSync = (filename: string, o: any) => {
  mkdirSync(dirname(filename), { recursive: true });
  writeFileSync(filename, JSON.stringify(o, null, 2));
};

export const createIndexes = (sets: {
  [k: string]: { Name: { EN: string; CHS: string; ID: string }; Id: number };
}): { [k: string]: number } => {
  return reduce(
    sets,
    (indexes, s) =>
      s.Name
        ? {
            ...indexes,
            [s.Id]: s.Id,
            [s.Name.EN]: s.Id,
            [s.Name.CHS]: s.Id,
            [s.Name.ID]: s.Id,
          }
        : indexes,
    {},
  );
};

export const addPropSet = (addProps: { PropType?: string; Value?: number }[]) => {
  return addProps
    .filter((p) => p.PropType)
    .reduce(
      (r: any, p: any) => ({
        ...r,
        [p.PropType]: p.Value || 0,
      }),
      {},
    );
};
