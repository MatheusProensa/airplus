package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.room.utils.Vector3d;
   
   [SecureSWF(rename="true")]
   public class WiredMovementsMessageParser implements IMessageParser
   {
      private var _userMoves:Array;
      
      private var _furniMoves:Array;
      
      private var _wallItemMoves:Array;
      
      private var _userDirectionUpdates:Array;
      
      public function WiredMovementsMessageParser()
      {
         super();
      }
      
      private static function parseUserMove(param1:IMessageDataWrapper) : WiredUserMoveMessageData
      {
         var _loc3_:Number = param1.readInteger();
         var _loc4_:Number = param1.readInteger();
         var _loc10_:Number = param1.readInteger();
         var _loc9_:Number = param1.readInteger();
         var _loc5_:Number = Number(param1.readString());
         var _loc8_:Number = Number(param1.readString());
         var _loc6_:Number = param1.readInteger();
         var _loc13_:Number = param1.readInteger();
         var _loc2_:Number = param1.readInteger();
         var _loc11_:Number = param1.readInteger();
         var _loc7_:Number = param1.readInteger();
         var _loc12_:Number = NaN;
         if(param1.readBoolean())
         {
            _loc12_ = param1.readInteger();
         }
         return new WiredUserMoveMessageData(_loc6_,new Vector3d(_loc3_,_loc4_,_loc5_),new Vector3d(_loc10_,_loc9_,_loc8_),_loc13_ == 0 ? "mv" : "sld",_loc2_,_loc11_,_loc7_,_loc12_);
      }
      
      private static function parseFurniMove(param1:IMessageDataWrapper) : WiredFurniMoveMessageData
      {
         var _loc3_:Number = param1.readInteger();
         var _loc4_:Number = param1.readInteger();
         var _loc10_:Number = param1.readInteger();
         var _loc8_:Number = param1.readInteger();
         var _loc5_:Number = Number(param1.readString());
         var _loc7_:Number = Number(param1.readString());
         var _loc6_:Number = param1.readInteger();
         var _loc2_:Number = param1.readInteger();
         var _loc9_:Number = param1.readInteger();
         var _loc11_:Number = NaN;
         if(param1.readBoolean())
         {
            _loc11_ = param1.readInteger();
         }
         var _loc12_:Number = NaN;
         if(param1.readBoolean())
         {
            _loc12_ = param1.readInteger();
         }
         return new WiredFurniMoveMessageData(_loc6_,new Vector3d(_loc3_,_loc4_,_loc5_),new Vector3d(_loc10_,_loc8_,_loc7_),_loc2_,_loc9_,_loc11_,_loc12_);
      }
      
      private static function parseWallItemMove(param1:IMessageDataWrapper) : WiredWallItemMoveMessageData
      {
         var _loc4_:Number = param1.readInteger();
         var _loc6_:Boolean = param1.readBoolean();
         var _loc10_:int = param1.readInteger();
         var _loc9_:int = param1.readInteger();
         var _loc7_:int = param1.readInteger();
         var _loc8_:int = param1.readInteger();
         var _loc5_:int = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc11_:int = param1.readInteger();
         var _loc12_:int = param1.readInteger();
         var _loc3_:int = param1.readInteger();
         return new WiredWallItemMoveMessageData(_loc4_,_loc6_,_loc10_,_loc9_,_loc7_,_loc8_,_loc5_,_loc2_,_loc11_,_loc12_,_loc3_);
      }
      
      private static function parseUserDirUpdate(param1:IMessageDataWrapper) : UserDirectionUpdateMessageData
      {
         var _loc3_:Number = param1.readInteger();
         var _loc2_:Number = param1.readInteger();
         var _loc4_:Number = param1.readInteger();
         return new UserDirectionUpdateMessageData(_loc3_,_loc2_,_loc4_);
      }
      
      public function flush() : Boolean
      {
         _userMoves = [];
         _furniMoves = [];
         _wallItemMoves = [];
         _userDirectionUpdates = [];
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         if(param1 == null)
         {
            return false;
         }
         _userMoves = [];
         _furniMoves = [];
         _wallItemMoves = [];
         _userDirectionUpdates = [];
         var _loc2_:int = param1.readInteger();
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1.readInteger();
            switch(_loc3_)
            {
               case 0:
                  _userMoves.push(parseUserMove(param1));
                  break;
               case 1:
                  _furniMoves.push(parseFurniMove(param1));
                  break;
               case 2:
                  _wallItemMoves.push(parseWallItemMove(param1));
                  break;
               case 3:
                  _userDirectionUpdates.push(parseUserDirUpdate(param1));
                  break;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function get userMoves() : Array
      {
         return _userMoves;
      }
      
      public function get furniMoves() : Array
      {
         return _furniMoves;
      }
      
      public function get wallItemMoves() : Array
      {
         return _wallItemMoves;
      }
      
      public function get userDirectionUpdates() : Array
      {
         return _userDirectionUpdates;
      }
   }
}

