package com.sulake.habbo.communication.messages.parser.marketplace
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.marketplace.MarketPlaceOffer;
   import com.sulake.habbo.communication.messages.parser.room.engine.UnknownHabboCommunicationMessagesParserRoomEngine1;
   import com.sulake.habbo.room.IStuffData;
   import com.sulake.habbo.room.object.data.UnknownHabboRoomObjectData1;
   
   [SecureSWF(rename="true")]
   public class MarketPlaceOffersParser implements IMessageParser
   {
      public static const UnknownConstFromGetMarketplaceItemStatsComposer_Int_1:int = 1;
      
      public static const UnknownConstFromGetMarketplaceItemStatsComposer_Int_2:int = 2;
      
      public static const UnknownConstFromMarketPlaceOffersParser_Int_1:int = 3;
      
      public static const UnknownConstFromMarketPlaceOffersParser_Int_2:int = 4;
      
      private const UnknownConstFromMarketPlaceOffersParser_Int_3:int = 500;
      
      private var _offers:Array;
      
      private var _totalItemsFound:int;
      
      public function MarketPlaceOffersParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         _offers = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc14_:int = 0;
         var _loc16_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc13_:int = 0;
         var _loc8_:int = 0;
         var _loc15_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:* = false;
         var _loc9_:Boolean = false;
         var _loc3_:MarketPlaceOffer = null;
         _offers = [];
         var _loc5_:String = "";
         var _loc12_:IStuffData = null;
         var _loc10_:int = param1.readInteger();
         _loc7_ = 0;
         while(_loc7_ < _loc10_)
         {
            _loc12_ = null;
            _loc5_ = "";
            _loc11_ = false;
            _loc9_ = false;
            _loc14_ = param1.readInteger();
            _loc16_ = param1.readInteger();
            _loc2_ = param1.readInteger();
            if(_loc2_ == 1 || _loc2_ == 4)
            {
               _loc4_ = param1.readInteger();
               _loc12_ = UnknownHabboCommunicationMessagesParserRoomEngine1.parseStuffData(param1);
               _loc11_ = _loc2_ == 4;
               if(_loc11_)
               {
                  _loc9_ = param1.readBoolean();
                  _loc2_ = 1;
               }
            }
            else if(_loc2_ == 2)
            {
               _loc4_ = param1.readInteger();
               _loc5_ = param1.readString();
            }
            else if(_loc2_ == 3)
            {
               _loc4_ = param1.readInteger();
               _loc12_ = UnknownHabboRoomObjectData1.getStuffDataWrapperForType(0);
               _loc12_.uniqueSerialNumber = param1.readInteger();
               _loc12_.uniqueSeriesSize = param1.readInteger();
               _loc2_ = 1;
            }
            _loc13_ = param1.readInteger();
            _loc8_ = param1.readInteger();
            _loc15_ = param1.readInteger();
            _loc6_ = param1.readInteger();
            _loc3_ = new MarketPlaceOffer(_loc14_,_loc4_,_loc2_,_loc5_,_loc12_,_loc13_,_loc16_,_loc8_,_loc15_,_loc6_,NaN,_loc11_,_loc9_);
            if(_loc7_ < 500)
            {
               _offers.push(_loc3_);
            }
            _loc7_++;
         }
         _totalItemsFound = param1.readInteger();
         return true;
      }
      
      public function get offers() : Array
      {
         return _offers;
      }
      
      public function get totalItemsFound() : int
      {
         return _totalItemsFound;
      }
   }
}

