import './main.css';
import { Main } from './Main.elm';
import registerServiceWorker from './registerServiceWorker';

var app = Main.embed(document.getElementById('root'));

registerServiceWorker();

// ports related code
console.log(app);

app.ports.windowTitle.subscribe(function(newTitle){
    window.document.title = newTitle;
});
