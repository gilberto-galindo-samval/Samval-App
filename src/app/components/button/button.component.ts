import { Component } from '@angular/core';
import { ButtonModule } from 'primeng/button';
import { environment } from '../../../environments/environment';

@Component({
  selector: 'app-button',
  imports: [ButtonModule],
  templateUrl: './button.component.html',
  styleUrl: './button.component.less'
})
export class ButtonComponent {

  enviroment = environment.production

}
