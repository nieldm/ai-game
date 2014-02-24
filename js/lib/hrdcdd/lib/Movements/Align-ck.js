var __hasProp={}.hasOwnProperty,__extends=function(e,t){function r(){this.constructor=e}for(var n in t)__hasProp.call(t,n)&&(e[n]=t[n]);r.prototype=t.prototype;e.prototype=new r;e.__super__=t.prototype;return e};define(["Phaser","KinematicSteeringOutput"],function(e,t){var n;n=function(n){function r(e,t,n,r,i,s){this.character=e;this.target=t;this.maxAngularAcceleration=n;this.maxRotation=r;this.targetRadius=i;this.slowRadius=s;this.timeToTarget=.5}__extends(r,n);r.prototype.getSteering=function(){var n,r,i,s,o;s=new t;r=this.target.orientation-this.character.orientation;r=e.Math.mapLinear(r,-this.maxRotation,this.maxRotation,-Math.PI,Math.PI);i=Math.abs(r);if(i<this.targetRadius)return null;i>this.slowRadius?o=this.maxRotation:o=this.maxRotation*i/this.slowRadius;o*=r/i;s.angular=o-this.character.rotation;s.angular/=this.timeToTarget;n=Math.abs(s.angular);if(n>this.maxAngularAcceleration){s.angular/=n;s.angular*=this.maxAngularAcceleration}s.linear.setTo(0,0);return s};return r}(e.Sprite);return n});