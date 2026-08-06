package com.sulake.core.window.motion
{
   import com.sulake.core.window.IWindowModel;
   
   use namespace friend;
   
   public class Dispose extends Motion
   {
      public function Dispose(param1:IWindowModel)
      {
         super(param1);
      }
      
      override friend function tick(param1:int) : void
      {
         super.friend::tick(param1);
         if(target && !target.disposed)
         {
            target.dispose();
            target = null;
         }
      }
   }
}

