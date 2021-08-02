import https from 'https'
export default function axios({ $axios }) {
  $axios.defaults.httpAgent = new https.Agent({ rejectUnauthorized: false })
  /* const agent = new https.Agent({ rejectUnauthorized: false })
  $axios.onRequest(function (config) {
    config.httpsAgent = agent
  }) */
}
