module.exports = function (api) {
  api.cache(true);

  const presets = [
    ["@babel/preset-env", { targets: "> 0.25%, not dead" }]
  ];

  const plugins = [
    ["@babel/plugin-proposal-class-properties", { loose: true }],
    ["@babel/plugin-proposal-private-methods", { loose: true }],
    ["@babel/plugin-proposal-private-property-in-object", { loose: true }],
    "@babel/plugin-proposal-optional-chaining",
    "@babel/plugin-proposal-logical-assignment-operators",
    "@babel/plugin-proposal-nullish-coalescing-operator"  // <-- this one fixes ??
  ];

  return { presets, plugins };
};