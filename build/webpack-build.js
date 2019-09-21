const { spawn } = require('child_process');
const cmd = spawn('cmd', ['/c', '.\\build\\webpack-build.cmd', process.argv[2]]);


cmd.stdout.on('data', (data) => {
    console.log(data.toString());
  });
  
  cmd.stderr.on('data', (data) => {
    console.log(data.toString());
  });
  
  cmd.on('exit', (code) => {
    console.log(`Child exited with code ${code}`);
  });