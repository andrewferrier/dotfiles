const remarkConfig = {
  plugins: [
    process.env.NPM_PACKAGES + '/lib/node_modules/remark-frontmatter/index.js',
    process.env.NPM_PACKAGES + '/lib/node_modules/remark-gfm/index.js'
  ]
}

export default remarkConfig
