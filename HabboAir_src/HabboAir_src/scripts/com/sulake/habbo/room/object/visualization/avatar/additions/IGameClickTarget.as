package com.sulake.habbo.room.object.visualization.avatar.additions
{
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   import com.sulake.room.object.visualization.IRoomObjectSprite;
   
   public interface IGameClickTarget extends IComponentInterfaceQueue
   {
      function get id() : int;
      
      function update(param1:IRoomObjectSprite, param2:Number) : void;
      
      function animate(param1:IRoomObjectSprite) : Boolean;
   }
}

