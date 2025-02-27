# 本地json-server
```shell
npm install -g json-server
json-server --host 0.0.0.0 --port 3000 --watch db.json  
```
# 一次开发，多端部署的具体实践
1. 深入理解三层目录架构的含义
2. 导包、引用问题  
被引用的包内的index.ets中导出
要引用的包中oh-package.json5内设置依赖 形如 
```json
{
  "name": "phone",
  "version": "1.0.0",
  "description": "Please describe the basic information.",
  "main": "",
  "author": "",
  "license": "",
  "dependencies": {
    "api_library_static": "file:../../commons/api_Library_Static",
    "tools": "file:../../commons/tools",
    "ui_library": "file:../../commons/UI_Library",
    "@ohos/axios": "^2.2.4"
  },
  "devDependencies": {},
  "dynamicDependencies": {}
}
```
使用处 形如：
``` javascript
import { AxiosResponse } from '@ohos/axios';
import { Api } from 'api_library_static'
import { CardModifierFromLibrary,cardModifierFromLibrary8,cardModifierFromLibrary16 } from 'ui_library'
```

# 小知识点
* SymbolGlyph 字体Icon可多色