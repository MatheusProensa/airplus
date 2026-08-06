package com.sulake.habbo.communication.messages.outgoing.roomsettings
{
   import com.sulake.core.communication.messages.IMessageComposer;
   import com.sulake.core.runtime.IComponentInterfaceQueue;
   
   [SecureSWF(rename="true")]
   public class SaveRoomSettingsMessageComposer implements IMessageComposer, IComponentInterfaceQueue
   {
      private var _messageArray:Array;
      
      public function SaveRoomSettingsMessageComposer(param1:SaveableRoomSettingsData)
      {
         var _loc4_:Array = null;
         _messageArray = [];
         super();
         _messageArray.push(param1.roomId);
         _messageArray.push(param1.name);
         _messageArray.push(param1.description);
         _messageArray.push(param1.doorMode);
         _messageArray.push(param1.password !== null ? param1.password : "");
         _messageArray.push(param1.maximumVisitors);
         _messageArray.push(param1.categoryId);
         if(param1.tags)
         {
            _loc4_ = [];
            for each(var _loc3_ in param1.tags)
            {
               if(_loc3_ && _loc3_ !== "")
               {
                  _loc4_.push(_loc3_);
               }
            }
            _messageArray.push(_loc4_.length);
            for each(var _loc2_ in _loc4_)
            {
               _messageArray.push(_loc2_);
            }
         }
         else
         {
            _messageArray.push(0);
         }
         _messageArray.push(param1.tradeMode);
         _messageArray.push(param1.allowPets);
         _messageArray.push(param1.allowFoodConsume);
         _messageArray.push(param1.allowWalkThrough);
         _messageArray.push(param1.hideWalls);
         _messageArray.push(param1.wallThickness);
         _messageArray.push(param1.floorThickness);
         _messageArray.push(param1.whoCanMute);
         _messageArray.push(param1.whoCanKick);
         _messageArray.push(param1.whoCanBan);
         _messageArray.push(param1.chatFloodSensitivity);
         _messageArray.push(param1.leaveOnDoorTileEnabled);
         _messageArray.push(param1.idleSleepEnabled);
         _messageArray.push(param1.idleSleepTimeoutSeconds);
         _messageArray.push(param1.idleAutokickEnabled);
         _messageArray.push(param1.idleAutokickTimeoutSeconds);
         _messageArray.push(param1.muteAllPets);
      }
      
      public function getMessageArray() : Array
      {
         return _messageArray;
      }
      
      public function dispose() : void
      {
         _messageArray = null;
      }
      
      public function get disposed() : Boolean
      {
         return false;
      }
   }
}

