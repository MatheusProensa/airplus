package com.sulake.habbo.room.object.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class CrackableStuffData extends StuffDataBase implements IStuffData
   {
      public static const FORMAT_KEY:int = 7;
      
      private static const INTERNAL_STATE_KEY:String = "furniture_crackable_state";
      
      private static const INTERNAL_HIT_KEY:String = "furniture_crackable_hits";
      
      private static const INTERNAL_TARGET_KEY:String = "furniture_crackable_target";
      
      private var _legacyString:String = "";
      
      private var _hits:int;
      
      private var _target:int;
      
      public function CrackableStuffData()
      {
         super();
      }
      
      override public function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void
      {
         _legacyString = param1.readString();
         _hits = param1.readInteger();
         _target = param1.readInteger();
         super.initializeFromIncomingMessage(param1);
      }
      
      override public function writeRoomObjectModel(param1:IRoomObjectModelController) : void
      {
         super.writeRoomObjectModel(param1);
         param1.setNumber("furniture_data_format",7);
         param1.setString("furniture_crackable_state",_legacyString);
         param1.setNumber("furniture_crackable_hits",_hits);
         param1.setNumber("furniture_crackable_target",_target);
      }
      
      override public function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void
      {
         super.initializeFromRoomObjectModel(param1);
         _legacyString = param1.getString("furniture_crackable_state");
         _hits = param1.getNumber("furniture_crackable_hits");
         _target = param1.getNumber("furniture_crackable_target");
      }
      
      override public function getLegacyString() : String
      {
         return _legacyString;
      }
      
      public function setString(param1:String) : void
      {
         _legacyString = param1;
      }
      
      public function get hits() : int
      {
         return _hits;
      }
      
      public function get target() : int
      {
         return _target;
      }
      
      override public function compare(param1:IStuffData) : Boolean
      {
         return true;
      }
   }
}

