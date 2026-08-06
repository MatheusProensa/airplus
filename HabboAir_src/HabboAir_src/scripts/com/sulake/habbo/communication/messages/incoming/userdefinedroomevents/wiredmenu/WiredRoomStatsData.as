package com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   public class WiredRoomStatsData
   {
      private var _executionCost:Number;
      
      private var _executionCostCap:Number;
      
      private var _isHeavy:Boolean;
      
      private var _floorItemCount:int;
      
      private var _floorItemCap:int;
      
      private var _wallItemCount:int;
      
      private var _wallItemCap:int;
      
      private var _permanentFurniVariables:int;
      
      private var _maxPermanentFurniVariables:int;
      
      private var _permanentUserVariables:int;
      
      private var _maxPermanentUserVariables:int;
      
      private var _permanentGlobalVariables:int;
      
      private var _maxPermanentGlobalVariables:int;
      
      public function WiredRoomStatsData(param1:IMessageDataWrapper)
      {
         super();
         _executionCost = param1.readDouble();
         _executionCostCap = param1.readDouble();
         _isHeavy = param1.readBoolean();
         _floorItemCount = param1.readInteger();
         _floorItemCap = param1.readInteger();
         _wallItemCount = param1.readInteger();
         _wallItemCap = param1.readInteger();
         _permanentFurniVariables = param1.readInteger();
         _maxPermanentFurniVariables = param1.readInteger();
         _permanentUserVariables = param1.readInteger();
         _maxPermanentUserVariables = param1.readInteger();
         _permanentGlobalVariables = param1.readInteger();
         _maxPermanentGlobalVariables = param1.readInteger();
      }
      
      public function get executionCost() : Number
      {
         return _executionCost;
      }
      
      public function get executionCostCap() : Number
      {
         return _executionCostCap;
      }
      
      public function get isHeavy() : Boolean
      {
         return _isHeavy;
      }
      
      public function get floorItemCount() : int
      {
         return _floorItemCount;
      }
      
      public function get floorItemCap() : int
      {
         return _floorItemCap;
      }
      
      public function get wallItemCount() : int
      {
         return _wallItemCount;
      }
      
      public function get wallItemCap() : int
      {
         return _wallItemCap;
      }
      
      public function get permanentFurniVariables() : int
      {
         return _permanentFurniVariables;
      }
      
      public function get maxPermanentFurniVariables() : int
      {
         return _maxPermanentFurniVariables;
      }
      
      public function get permanentUserVariables() : int
      {
         return _permanentUserVariables;
      }
      
      public function get maxPermanentUserVariables() : int
      {
         return _maxPermanentUserVariables;
      }
      
      public function get permanentGlobalVariables() : int
      {
         return _permanentGlobalVariables;
      }
      
      public function get maxPermanentGlobalVariables() : int
      {
         return _maxPermanentGlobalVariables;
      }
   }
}

