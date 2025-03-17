/* tslint:disable */
import { run } from './run-bin';
async function compileTypeScript () {
  await run('TypeScript', 'tsc', ['-p', 'tsconfig.json'])
};

export default compileTypeScript