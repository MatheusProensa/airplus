package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindowModel;
   
   use namespace friend;
   
   public class Motion
   {
      protected var _target:IWindowModel;
      
      protected var _running:Boolean;
      
      protected var _complete:Boolean = true;
      
      protected var _tag:String;
      
      public function Motion(param1:IWindowModel)
      {
         super();
         _target = param1;
      }
      
      public function get running() : Boolean
      {
         return _running && _target && !_target.disposed;
      }
      
      public function get complete() : Boolean
      {
         return _complete;
      }
      
      public function set target(param1:IWindowModel) : void
      {
         _target = param1;
      }
      
      public function get target() : IWindowModel
      {
         return _target;
      }
      
      public function set tag(param1:String) : void
      {
         _tag = param1;
      }
      
      public function get tag() : String
      {
         return _tag;
      }
      
      friend function start() : void
      {
         _running = true;
      }
      
      friend function update(param1:Number) : void
      {
      }
      
      friend function stop() : void
      {
         _target = null;
         _running = false;
      }
      
      friend function tick(param1:int) : void
      {
      }
   }
}

