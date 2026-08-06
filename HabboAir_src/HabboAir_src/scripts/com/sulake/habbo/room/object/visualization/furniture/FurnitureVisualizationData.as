package com.sulake.habbo.room.object.visualization.furniture
{
   import com.sulake.core.utils.Map;
   import com.sulake.habbo.room.object.visualization.data.SizeData;
   import com.sulake.room.object.visualization.IRoomObjectVisualizationData;
   import com.sulake.room.utils.UnknownRoomUtils1;
   
   public class FurnitureVisualizationData implements IRoomObjectVisualizationData
   {
      public static const LAYER_LIMIT:int = 1000;
      
      public static const LAYER_NAMES:Array = new Array("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z");
      
      private var UnknownVarFromFurnitureVisualizationData_Map_1:Map;
      
      private var _sizes:Array = [];
      
      private var UnknownVarFromFurnitureVisualizationData_SizeData_1:SizeData = null;
      
      private var UnknownVarFromFurnitureVisualizationData_Int_1:int = -1;
      
      private var UnknownVarFromFurnitureVisualizationData_Int_2:int = -1;
      
      private var UnknownVarFromFurnitureVisualizationData_Int_3:int = -1;
      
      private var _type:String = "";
      
      public function FurnitureVisualizationData()
      {
         super();
         UnknownVarFromFurnitureVisualizationData_Map_1 = new Map();
      }
      
      public function dispose() : void
      {
         var _loc1_:SizeData = null;
         var _loc2_:int = 0;
         if(UnknownVarFromFurnitureVisualizationData_Map_1 != null)
         {
            _loc1_ = null;
            _loc2_ = 0;
            while(_loc2_ < UnknownVarFromFurnitureVisualizationData_Map_1.length)
            {
               _loc1_ = UnknownVarFromFurnitureVisualizationData_Map_1.getWithIndex(_loc2_) as SizeData;
               if(_loc1_ != null)
               {
                  _loc1_.dispose();
               }
               _loc2_++;
            }
            UnknownVarFromFurnitureVisualizationData_Map_1.dispose();
            UnknownVarFromFurnitureVisualizationData_Map_1 = null;
         }
         UnknownVarFromFurnitureVisualizationData_SizeData_1 = null;
         _sizes = null;
      }
      
      public function initialize(param1:XML) : Boolean
      {
         reset();
         if(param1 == null)
         {
            return false;
         }
         var _loc2_:String = param1.@type;
         if(_loc2_.length == 0)
         {
            return false;
         }
         _type = _loc2_;
         if(!defineVisualizations(param1))
         {
            reset();
            return false;
         }
         return true;
      }
      
      protected function reset() : void
      {
         var _loc2_:int = 0;
         _type = "";
         var _loc1_:SizeData = null;
         _loc2_ = 0;
         while(_loc2_ < UnknownVarFromFurnitureVisualizationData_Map_1.length)
         {
            _loc1_ = UnknownVarFromFurnitureVisualizationData_Map_1.getWithIndex(_loc2_) as SizeData;
            if(_loc1_ != null)
            {
               _loc1_.dispose();
            }
            _loc2_++;
         }
         UnknownVarFromFurnitureVisualizationData_Map_1.reset();
         _sizes = [];
         UnknownVarFromFurnitureVisualizationData_SizeData_1 = null;
         UnknownVarFromFurnitureVisualizationData_Int_1 = -1;
      }
      
      protected function defineVisualizations(param1:XML) : Boolean
      {
         var _loc7_:int = 0;
         var _loc2_:XML = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc11_:SizeData = null;
         var _loc5_:XMLList = null;
         var _loc9_:int = 0;
         var _loc12_:XML = null;
         var _loc10_:XMLList = param1.graphics.visualization;
         if(_loc10_.length() == 0)
         {
            return false;
         }
         var _loc6_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc10_.length())
         {
            _loc2_ = _loc10_[_loc7_];
            if(!UnknownRoomUtils1.checkRequiredAttributes(_loc2_,["size","layerCount","angle"]))
            {
               return false;
            }
            _loc3_ = int(_loc2_.@size);
            _loc4_ = int(_loc2_.@layerCount);
            _loc8_ = int(_loc2_.@angle);
            if(_loc3_ < 1)
            {
               _loc3_ = 1;
            }
            if(UnknownVarFromFurnitureVisualizationData_Map_1.getValue(String(_loc3_)) != null)
            {
               return false;
            }
            _loc11_ = createSizeData(_loc3_,_loc4_,_loc8_);
            if(_loc11_ == null)
            {
               return false;
            }
            _loc5_ = _loc2_.children();
            _loc9_ = 0;
            while(_loc9_ < _loc5_.length())
            {
               _loc12_ = _loc5_[_loc9_];
               if(!processVisualizationElement(_loc11_,_loc12_))
               {
                  _loc11_.dispose();
                  return false;
               }
               _loc9_++;
            }
            UnknownVarFromFurnitureVisualizationData_Map_1.add(String(_loc3_),_loc11_);
            _sizes.push(_loc3_);
            _sizes.sort(16);
            _loc7_++;
         }
         return true;
      }
      
      protected function createSizeData(param1:int, param2:int, param3:int) : SizeData
      {
         var _loc4_:SizeData = null;
         return new SizeData(param2,param3);
      }
      
      protected function processVisualizationElement(param1:SizeData, param2:XML) : Boolean
      {
         if(param1 == null || param2 == null)
         {
            return false;
         }
         switch(String(param2.name()))
         {
            case "layers":
               if(!param1.defineLayers(param2))
               {
                  return false;
               }
               break;
            case "directions":
               if(!param1.defineDirections(param2))
               {
                  return false;
               }
               break;
            case "colors":
               if(!param1.defineColors(param2))
               {
                  return false;
               }
               break;
         }
         return true;
      }
      
      public function getType() : String
      {
         return _type;
      }
      
      private function getSizeIndex(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = 0;
         if(param1 > 0)
         {
            _loc3_ = 1;
            while(_loc3_ < _sizes.length)
            {
               if(_sizes[_loc3_] > param1)
               {
                  if(_sizes[_loc3_] / param1 < param1 / _sizes[_loc3_ - 1])
                  {
                     _loc2_ = _loc3_;
                  }
                  break;
               }
               _loc2_ = _loc3_;
               _loc3_++;
            }
         }
         return _loc2_;
      }
      
      public function getSize(param1:int) : int
      {
         if(param1 == UnknownVarFromFurnitureVisualizationData_Int_3)
         {
            return UnknownVarFromFurnitureVisualizationData_Int_2;
         }
         var _loc2_:int = getSizeIndex(param1);
         var _loc3_:int = -1;
         if(_loc2_ < _sizes.length)
         {
            _loc3_ = int(_sizes[_loc2_]);
         }
         UnknownVarFromFurnitureVisualizationData_Int_3 = param1;
         UnknownVarFromFurnitureVisualizationData_Int_2 = _loc3_;
         return _loc3_;
      }
      
      public function getLayerCount(param1:int) : int
      {
         var _loc2_:SizeData = getSizeData(param1);
         if(_loc2_ != null)
         {
            return _loc2_.layerCount;
         }
         return 0;
      }
      
      public function getDirectionValue(param1:int, param2:int) : int
      {
         var _loc3_:SizeData = getSizeData(param1);
         if(_loc3_ != null)
         {
            return _loc3_.getDirectionValue(param2);
         }
         return 0;
      }
      
      public function getTag(param1:int, param2:int, param3:int) : String
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getTag(param2,param3);
         }
         return "";
      }
      
      public function getInk(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getInk(param2,param3);
         }
         return 0;
      }
      
      public function getAlpha(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getAlpha(param2,param3);
         }
         return 255;
      }
      
      public function getColor(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getColor(param2,param3);
         }
         return 16777215;
      }
      
      public function getIgnoreMouse(param1:int, param2:int, param3:int) : Boolean
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getIgnoreMouse(param2,param3);
         }
         return false;
      }
      
      public function getXOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getXOffset(param2,param3);
         }
         return 0;
      }
      
      public function getYOffset(param1:int, param2:int, param3:int) : int
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getYOffset(param2,param3);
         }
         return 0;
      }
      
      public function getZOffset(param1:int, param2:int, param3:int) : Number
      {
         var _loc4_:SizeData = getSizeData(param1);
         if(_loc4_ != null)
         {
            return _loc4_.getZOffset(param2,param3);
         }
         return 0;
      }
      
      protected function getSizeData(param1:int) : SizeData
      {
         if(param1 == UnknownVarFromFurnitureVisualizationData_Int_1)
         {
            return UnknownVarFromFurnitureVisualizationData_SizeData_1;
         }
         var _loc2_:int = getSizeIndex(param1);
         if(_loc2_ < _sizes.length)
         {
            UnknownVarFromFurnitureVisualizationData_SizeData_1 = UnknownVarFromFurnitureVisualizationData_Map_1.getValue(String(_sizes[_loc2_])) as SizeData;
         }
         else
         {
            UnknownVarFromFurnitureVisualizationData_SizeData_1 = null;
         }
         UnknownVarFromFurnitureVisualizationData_Int_1 = param1;
         return UnknownVarFromFurnitureVisualizationData_SizeData_1;
      }
   }
}

