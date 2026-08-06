package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredtrading.chests.storage
{
   import com.sulake.habbo.room.IStuffData;
   
   public interface IChestStorage
   {
      function get type() : ChestItemType;
      
      function get specialType() : int;
      
      function get stuffData() : IStuffData;
   }
}

