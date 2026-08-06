package com.sulake.habbo.room.object.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class LegacyStuffData extends StuffDataBase implements IStuffData
   {
      public static const FORMAT_KEY:int = 0;
      
      private var _legacyString:String = "";
      
      public function LegacyStuffData()
      {
         super();
      }
      
      override public function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void
      {
         _legacyString = param1.readString();
         super.initializeFromIncomingMessage(param1);
      }
      
      override public function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void
      {
         super.initializeFromRoomObjectModel(param1);
         _legacyString = param1.getString("furniture_data");
      }
      
      override public function writeRoomObjectModel(param1:IRoomObjectModelController) : void
      {
         super.writeRoomObjectModel(param1);
         param1.setNumber("furniture_data_format",0);
         param1.setString("furniture_data",_legacyString);
      }
      
      override public function getLegacyString() : String
      {
         return _legacyString;
      }
      
      public function setString(param1:String) : void
      {
         _legacyString = param1;
      }
      
      override public function compare(param1:IStuffData) : Boolean
      {
         return _legacyString == param1.getLegacyString();
      }
   }
}

