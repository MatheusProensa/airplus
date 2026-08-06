package com.sulake.habbo.room.object.visualization.room.rasterizer.basic
{
   import com.sulake.habbo.room.object.visualization.room.utils.PlaneBitmapData;
   import com.sulake.room.utils.IVector3d;
   import com.sulake.room.utils.UnknownRoomUtils1;
   import flash.display.BitmapData;
   
   public class FloorRasterizer extends PlaneRasterizer
   {
      public function FloorRasterizer()
      {
         super();
      }
      
      override protected function initializePlanes() : void
      {
         if(data == null)
         {
            return;
         }
         var _loc1_:XMLList = data.floors;
         if(_loc1_.length() > 0)
         {
            parseFloors(_loc1_[0]);
         }
      }
      
      private function parseFloors(param1:XML) : void
      {
         var _loc4_:int = 0;
         var _loc7_:XML = null;
         var _loc5_:String = null;
         var _loc3_:XMLList = null;
         var _loc6_:UnknownHabboRoomObjectVisualizationRoomRasterizerBasic1 = null;
         if(param1 == null)
         {
            return;
         }
         var _loc2_:XMLList = param1.floor;
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length())
         {
            _loc7_ = _loc2_[_loc4_];
            if(UnknownRoomUtils1.checkRequiredAttributes(_loc7_,["id"]))
            {
               _loc5_ = _loc7_.@id;
               _loc3_ = _loc7_.visualization;
               _loc6_ = new UnknownHabboRoomObjectVisualizationRoomRasterizerBasic1();
               parseVisualizations(_loc6_,_loc3_);
               if(!addPlane(_loc5_,_loc6_))
               {
                  _loc6_.dispose();
               }
            }
            _loc4_++;
         }
      }
      
      override public function render(param1:BitmapData, param2:String, param3:Number, param4:Number, param5:Number, param6:IVector3d, param7:Boolean, param8:Number = 0, param9:Number = 0, param10:Number = 0, param11:Number = 0, param12:int = 0) : PlaneBitmapData
      {
         var _loc15_:UnknownHabboRoomObjectVisualizationRoomRasterizerBasic1 = getPlane(param2) as UnknownHabboRoomObjectVisualizationRoomRasterizerBasic1;
         if(_loc15_ == null)
         {
            _loc15_ = getPlane("default") as UnknownHabboRoomObjectVisualizationRoomRasterizerBasic1;
         }
         if(_loc15_ == null)
         {
            return null;
         }
         if(param1 != null)
         {
            param1.fillRect(param1.rect,16777215);
         }
         var _loc14_:BitmapData = _loc15_.render(param1,param3,param4,param5,param6,param7,param8,param9);
         if(_loc14_ != null && _loc14_ != param1)
         {
            try
            {
               _loc14_ = _loc14_.clone();
            }
            catch(e:Error)
            {
               if(_loc14_)
               {
                  _loc14_.dispose();
               }
               return null;
            }
         }
         return new PlaneBitmapData(_loc14_,-1);
      }
   }
}

