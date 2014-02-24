var __hasProp={}.hasOwnProperty,__extends=function(e,t){function r(){this.constructor=e}for(var n in t)__hasProp.call(t,n)&&(e[n]=t[n]);r.prototype=t.prototype;e.prototype=new r;e.__super__=t.prototype;return e};define(["Phaser","/js/lib/hrdcdd/lib/Movements/KinematicSteeringOutput.js"],function(e,t){var n;n=function(n){function r(e,t,n,r,i){this.character=e;this.target=t;this.maxSpeed=n;this.radius=r;this.time=i}__extends(r,n);r.prototype.getSteering=function(){var n;n=new t;e.Point.subtract(this.target.position,this.character.position,n.velocity);if(n.velocity.getMagnitude()<this.radius)return null;n.velocity.divide(this.time,this.time);if(n.velocity.getMagnitude()>this.maxSpeed){n.velocity.normalize();n.velocity.multiply(this.maxSpeed,this.maxSpeed)}n.rotation=this.getNewOrientation(this.character.rotation,n.velocity);return n};r.prototype.getNewOrientation=function(e,t){return t.getMagnitude()>0?Math.atan2(-t.x,t.y):e};return r}(e.Sprite);return n});