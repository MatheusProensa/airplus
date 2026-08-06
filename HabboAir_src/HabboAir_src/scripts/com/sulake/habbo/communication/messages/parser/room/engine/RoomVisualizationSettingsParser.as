package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomVisualizationSettingsParser implements IMessageParser
   {
      private var _wallsHidden:Boolean = false;
      
      private var _wallThicknessMultiplier:Number = 1;
      
      private var _floorThicknessMultiplier:Number = 1;
      
      public function RoomVisualizationSettingsParser()
      {
         super();
      }
      
      public function get wallsHidden() : Boolean
      {
         return _wallsHidden;
      }
      
      public function get wallThicknessMultiplier() : Number
      {
         return _wallThicknessMultiplier;
      }
      
      public function get floorThicknessMultiplier() : Number
      {
         return _floorThicknessMultiplier;
      }
      
      public function flush() : Boolean
      {
         _wallsHidden = false;
         _wallThicknessMultiplier = 1;
         _floorThicknessMultiplier = 1;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         _wallsHidden = param1.readBoolean();
         var _loc3_:int = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         if(_loc3_ < -2)
         {
            _loc3_ = -2;
         }
         else if(_loc3_ > 1)
         {
            _loc3_ = 1;
         }
         if(_loc2_ < -2)
         {
            _loc2_ = -2;
         }
         else if(_loc2_ > 1)
         {
            _loc2_ = 1;
         }
         _wallThicknessMultiplier = Math.pow(2,_loc3_);
         _floorThicknessMultiplier = Math.pow(2,_loc2_);
         return true;
      }
   }
}

