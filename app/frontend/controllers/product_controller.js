import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["target"] 

  connect(){}
     quantity_minus(evt){
        evt.preventDefault();
        console.log('-')
     }

     quantity_plus(evt){
        evt.preventDefault();
        console.log('+')
     }
  }
