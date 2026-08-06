package com.sulake.habbo.room.object.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.*;
   import com.sulake.habbo.room.object.*;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class MapStuffData extends StuffDataBase implements IStuffData
   {
      public static const FORMAT_KEY:int = 1;
      
      private static const STATE_DEFAULT_KEY:String = "state";
      
      private static const UnknownConstFromMapStuffData_String_1:String = "rarity";
      
      private var UnknownVarFromMapStuffData_Map_1:Map;
      
      public function MapStuffData(param1:Map = null)
      {
         super();
         if(param1)
         {
            UnknownVarFromMapStuffData_Map_1 = param1;
         }
      }
      
      override public function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void
      {
         var _loc3_:int = 0;
         var _loc5_:String = null;
         var _loc4_:String = null;
         UnknownVarFromMapStuffData_Map_1 = new Map();
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc5_ = param1.readString();
            _loc4_ = param1.readString();
            UnknownVarFromMapStuffData_Map_1.add(_loc5_,_loc4_);
            _loc3_++;
         }
         super.initializeFromIncomingMessage(param1);
      }
      
      override public function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void
      {
         super.initializeFromRoomObjectModel(param1);
         UnknownVarFromMapStuffData_Map_1 = param1.getStringToStringMap("furniture_data");
      }
      
      override public function writeRoomObjectModel(param1:IRoomObjectModelController) : void
      {
         super.writeRoomObjectModel(param1);
         param1.setNumber("furniture_data_format",1);
         param1.setStringToStringMap("furniture_data",UnknownVarFromMapStuffData_Map_1);
      }
      
      override public function getLegacyString() : String
      {
         if(UnknownVarFromMapStuffData_Map_1 && UnknownVarFromMapStuffData_Map_1.getValue("state") != null)
         {
            return UnknownVarFromMapStuffData_Map_1["state"];
         }
         return "";
      }
      
      public function getValue(param1:String) : String
      {
         if(UnknownVarFromMapStuffData_Map_1 == null)
         {
            return null;
         }
         return UnknownVarFromMapStuffData_Map_1[param1];
      }
      
      override public function compare(param1:IStuffData) : Boolean
      {
         return false;
      }
      
      override public function get rarityLevel() : int
      {
         var _loc1_:String = UnknownVarFromMapStuffData_Map_1["rarity"];
         if(_loc1_)
         {
            return int(_loc1_);
         }
         return -1;
      }
      
      override public function get contentsCount() : int
      {
         var _loc1_:String = UnknownVarFromMapStuffData_Map_1["contents_count"];
         if(_loc1_)
         {
            return int(_loc1_);
         }
         return 0;
      }
      
      override public function get chestName() : String
      {
         var _loc1_:String = UnknownVarFromMapStuffData_Map_1["chest_name"];
         if(_loc1_ != null)
         {
            return _loc1_;
         }
         return "";
      }
   }
}

