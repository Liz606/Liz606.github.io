#### 安装vue
`npm install -g vue-cli`
#### 初始化vue模板
`vue init webpack [project name]`
#### 运行 Demo
`cd project`

`npm install`

`npm run dev`

`npm run build`
#### vue热加载
`npm install vue-hot-reload-api --save-dev`
#### 使用element-ui
`npm install element-ui --save`
 
router/index.js解读：
- name: 'Login'---->路由名称，不会渲染到页面，只会在调试台显示
- component: Login---->加载模块名称，与import模块名称一致



vue项目结构
├─build
├─config
├─node_modules
├─staitic
├─test
├─src
│ ├─assets
│ │  └─images
│ ├─components
│ │   ├─Vlink.vue
│ │   ├─404.vue
│ │   └─index.vue
│ ├─layouts
│ │   └─Main.vue
│ ├─pages
│ │   ├─404.vue
│ │   └─index.vue
│ └─router
│     ├─index.js//路由设置文件
│     └─routes.js//路由配置文件
└─index.html









使用element-ui
```
import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-default/index.css'

Vue.use(ElementUI)
```
配置element-ui组件按需引入
安装babel-plugin-component
`npm install babel-plugin-component --dev`
修改.babelrc 为：
```
{
  "presets": [
    ["env", { "es2015":{ "modules": false } }],"stage-2"
  ],
  "plugins": [["component", [
    {
      "libraryName": "element-ui",
      "styleLibraryName": "theme-default"
    }
  ]]],
  "comments": false,
  "env": {
    "test": {
      "presets": ["env", "stage-2"],
      "plugins": [ "istanbul" ]
    }
  }
}

```
使用按需加载组件
完整组件列表以 [components.json](https://github.com/ElemeFE/element/blob/dev/components.json) 为准
```
import Vue from 'vue'
import { Button, Select } from 'element-ui'
import 'element-ui/lib/theme-default/index.css'

Vue.use(Button)
Vue.use(Select)
```