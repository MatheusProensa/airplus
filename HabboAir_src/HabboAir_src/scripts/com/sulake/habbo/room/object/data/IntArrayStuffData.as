package com.sulake.habbo.room.object.data
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.room.object.IRoomObjectModel;
   import com.sulake.room.object.IRoomObjectModelController;
   
   public class IntArrayStuffData extends StuffDataBase implements IStuffData
   {
      public static const FORMAT_KEY:int = 5;
      
      private static const STATE_DEFAULT_INDEX:int = 0;
      
      private var UnknownVarFromIntArrayStuffData_Array_1:Array = [];
      
      public function IntArrayStuffData()
      {
         super();
      }
      
      override public function initializeFromIncomingMessage(param1:IMessageDataWrapper) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         UnknownVarFromIntArrayStuffData_Array_1 = [];
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = param1.readInteger();
            UnknownVarFromIntArrayStuffData_Array_1.push(_loc4_);
            _loc3_++;
         }
         super.initializeFromIncomingMessage(param1);
      }
      
      override public function initializeFromRoomObjectModel(param1:IRoomObjectModel) : void
      {
         super.initializeFromRoomObjectModel(param1);
         UnknownVarFromIntArrayStuffData_Array_1 = param1.getNumberArray("furniture_data");
      }
      
      override public function writeRoomObjectModel(param1:IRoomObjectModelController) : void
      {
         super.writeRoomObjectModel(param1);
         param1.setNumber("furniture_data_format",5);
         param1.setNumberArray("furniture_data",UnknownVarFromIntArrayStuffData_Array_1);
      }
      
      override public function getLegacyString() : String
      {
         if(!UnknownVarFromIntArrayStuffData_Array_1)
         {
            return "";
         }
         return UnknownVarFromIntArrayStuffData_Array_1[0];
      }
      
      public function getValue(param1:int) : int
      {
         if(UnknownVarFromIntArrayStuffData_Array_1 && param1 < UnknownVarFromIntArrayStuffData_Array_1.length)
         {
            return UnknownVarFromIntArrayStuffData_Array_1[param1];
         }
         return -1;
      }
      
      public function setArray(param1:Array) : void
      {
         UnknownVarFromIntArrayStuffData_Array_1 = param1;
      }
      
      override public function compare(param1:IStuffData) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:IntArrayStuffData = param1 as IntArrayStuffData;
         if(!_loc2_)
         {
            return false;
         }
         _loc3_ = 0;
         while(_loc3_ < UnknownVarFromIntArrayStuffData_Array_1.length)
         {
            if(_loc3_ != 0)
            {
               if(UnknownVarFromIntArrayStuffData_Array_1[_loc3_] != _loc2_.getValue(_loc3_))
               {
                  return false;
               }
            }
            _loc3_++;
         }
         return true;
      }
   }
}

