import { compileParcel } from './parcel-build'

async function watchParcel () {
  return compileParcel({ watch: true })
}

module.exports = {
  watchParcel
}

if (require.main === module) watchParcel()
