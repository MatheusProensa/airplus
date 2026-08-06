package com.sulake.room.renderer
{
   import com.sulake.core.runtime.Component;
   import com.sulake.core.runtime.IComponent_2;
   
   [SecureSWF(rename="true")]
   public class RoomRendererFactory extends Component implements IRoomRendererFactory
   {
      public function RoomRendererFactory(param1:IComponent_2, param2:uint = 0)
      {
         super(param1,param2);
      }
      
      public function createRenderer() : IRoomRenderer
      {
         return new RoomRenderer(this);
      }
   }
}

