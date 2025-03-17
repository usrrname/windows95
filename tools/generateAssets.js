
import { compileParcel } from './parcel-build'

export const generateAssets = async () => {
  await Promise.all([compileParcel()])
}
