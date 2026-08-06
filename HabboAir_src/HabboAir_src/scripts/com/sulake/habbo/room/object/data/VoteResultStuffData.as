package com.sulake.habbo.room.object.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class VoteResultStuffData extends StuffDataBase implements IStuffData
   {
      public static const FORMAT_KEY:int = 3;
      
      private static const INTERNAL_STATE_KEY:String = "s";
      
      private static const INTERNAL_RESULT_KEY:String = "r";
      
      private var _legacyString:String = "";
      
      private var _result:int;
      
      public function VoteResultStuffData()
      {
         super();
      }
      
      override public function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void
      {
         _legacyString = param1.readString();
         _result = param1.readInteger();
         super.initializeFromIncomingMessage(param1);
      }
      
      override public function writeRoomObjectModel(param1:IRoomObjectModelController) : void
      {
         super.writeRoomObjectModel(param1);
         param1.setNumber("furniture_data_format",3);
         var _loc2_:Map = new Map();
         _loc2_.add("s",_legacyString);
         _loc2_.add("r",_result.toString());
         param1.setStringToStringMap("furniture_data",_loc2_);
      }
      
      override public function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void
      {
         super.initializeFromRoomObjectModel(param1);
         var _loc2_:Map = param1.getStringToStringMap("furniture_data");
         _legacyString = _loc2_.getValue("s");
         _result = _loc2_.getValue("r");
      }
      
      override public function getLegacyString() : String
      {
         return _legacyString;
      }
      
      public function setString(param1:String) : void
      {
         _legacyString = param1;
      }
      
      public function get result() : int
      {
         return _result;
      }
      
      override public function compare(param1:IStuffData) : Boolean
      {
         return true;
      }
   }
}

