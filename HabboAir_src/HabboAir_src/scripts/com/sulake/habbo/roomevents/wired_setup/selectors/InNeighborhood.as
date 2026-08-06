package com.sulake.habbo.roomevents.wired_setup.selectors
{
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.Triggerable;
   import com.sulake.habbo.roomevents.HabboUserDefinedRoomEvents;
   import com.sulake.habbo.roomevents.wired_setup.DefaultElement;
   import com.sulake.habbo.roomevents.wired_setup.common.NeighborhoodFloor;
   import com.sulake.habbo.roomevents.wired_setup.common.utils.SpiralUtils;
   import com.sulake.habbo.roomevents.wired_setup.inputsources.WiredInputSourcePicker;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.PresetManager;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.WiredUIBuilder;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.AssetButtonParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.params.NumberInputParam;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.AssetButtonPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.AssetButtonRowPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SectionPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.SimpleListViewPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.FloorDrawingPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.applications.FloorEditorPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.presets.combinations.NamedNumberInputPreset;
   import com.sulake.habbo.roomevents.wired_setup.uibuilder.styles.WiredStyle;
   import flash.geom.Point;
   
   public class InNeighborhood extends DefaultSelectorType
   {
      private static var _drawModes:Array = ["add_tile","remove_tile","set_root_tile"];
      
      private var _drawMode:String = "add_tile";
      
      private var UnknownVarFromInNeighborhood_Point_1:Point;
      
      private var _floor:NeighborhoodFloor;
      
      private var UnknownVarFromInNeighborhood_Boolean_1:Boolean;
      
      private var UnknownVarFromInNeighborhood_FloorEditorPreset_1:FloorEditorPreset;
      
      private var UnknownVarFromInNeighborhood_FloorDrawingPreset_1:FloorDrawingPreset;
      
      private var UnknownVarFromInNeighborhood_NamedNumberInputPreset_1:NamedNumberInputPreset;
      
      private var UnknownVarFromInNeighborhood_NamedNumberInputPreset_2:NamedNumberInputPreset;
      
      private var _drawButtonsByMode:Object;
      
      private var _preferBigMode:Boolean = false;
      
      private var _inBigMode:Boolean = false;
      
      private var UnknownVarFromInNeighborhood_AssetButtonPreset_1:AssetButtonPreset;
      
      public function InNeighborhood()
      {
         super();
      }
      
      override public function get inputMode() : int
      {
         return DefaultElement.INPUTS_TYPE_UI_BUILDER;
      }
      
      override public function onInit(param1:HabboUserDefinedRoomEvents) : void
      {
         super.onInit(param1);
         setRootTileInternal(0,0,false);
         var _loc2_:Array = SpiralUtils.parseSpiralVector([],NeighborhoodFloor.RADIUS);
         _floor = new NeighborhoodFloor(_loc2_,!_preferBigMode,onDrawingChanged);
      }
      
      override public function onEditStart(param1:Triggerable) : void
      {
         _inBigMode = _preferBigMode;
         UnknownVarFromInNeighborhood_Boolean_1 = param1.getBoolean(0);
         setRootTileInternal(param1.intParams[1],param1.intParams[2],true);
         setMode("add_tile");
         var _loc2_:Array = SpiralUtils.parseSpiralVector(param1.intParams.slice(3),NeighborhoodFloor.RADIUS);
         _floor = new NeighborhoodFloor(_loc2_,!_inBigMode,onDrawingChanged);
         if(!_inBigMode && !_floor.smallModeAllowed())
         {
            _floor.smallMode = false;
            _inBigMode = true;
         }
         if(UnknownVarFromInNeighborhood_FloorDrawingPreset_1 != null)
         {
            UnknownVarFromInNeighborhood_FloorDrawingPreset_1.setFloor(_floor);
            UnknownVarFromInNeighborhood_FloorDrawingPreset_1.setMode(_drawMode);
         }
         updateResolutionButtonUI();
         roomEventsCtrl.resizeFrame();
      }
      
      private function updateResolutionButtonUI() : void
      {
         UnknownVarFromInNeighborhood_AssetButtonPreset_1.disabled = !_floor.smallModeAllowed();
         UnknownVarFromInNeighborhood_AssetButtonPreset_1.assetName = _inBigMode ? "reduce_image" : "enlarge_image";
      }
      
      override public function onEditEnd() : void
      {
         super.onEditEnd();
      }
      
      override public function readIntParamsFromForm() : Array
      {
         var _loc1_:Array = [];
         _loc1_.push(UnknownVarFromInNeighborhood_Boolean_1 ? 1 : 0);
         _loc1_.push(UnknownVarFromInNeighborhood_Point_1.x);
         _loc1_.push(UnknownVarFromInNeighborhood_Point_1.y);
         return _loc1_.concat(SpiralUtils.createSpiralVector(_floor.floorPlanCache,NeighborhoodFloor.RADIUS));
      }
      
      private function setMode(param1:String) : void
      {
         var _loc2_:AssetButtonPreset = null;
         _drawMode = param1;
         if(UnknownVarFromInNeighborhood_FloorDrawingPreset_1 != null)
         {
            UnknownVarFromInNeighborhood_FloorDrawingPreset_1.setMode(_drawMode);
         }
         if(_drawButtonsByMode == null)
         {
            return;
         }
         for each(var _loc3_ in _drawModes)
         {
            _loc2_ = _drawButtonsByMode[_loc3_];
            if(_loc2_ != null)
            {
               _loc2_.selected = _drawMode == _loc3_;
            }
         }
      }
      
      override public function mergedSelections() : Array
      {
         return [[0,0]];
      }
      
      override public function mergedSelectionTitle(param1:int) : String
      {
         return "wiredfurni.params.sources.merged.title.neighborhood";
      }
      
      override public function setMergedType(param1:int, param2:int) : void
      {
         UnknownVarFromInNeighborhood_Boolean_1 = param2 == WiredInputSourcePicker.USER_SOURCE;
      }
      
      override public function getMergedType(param1:int) : int
      {
         return UnknownVarFromInNeighborhood_Boolean_1 ? WiredInputSourcePicker.USER_SOURCE : WiredInputSourcePicker.UnknownVarFromWiredInputSourcePicker_Int_1;
      }
      
      override public function get forceHidePickFurniInstructions() : Boolean
      {
         return true;
      }
      
      override public function advancedAlwaysVisible() : Boolean
      {
         return true;
      }
      
      private function updateRootInputText() : void
      {
         if(UnknownVarFromInNeighborhood_NamedNumberInputPreset_1 != null)
         {
            UnknownVarFromInNeighborhood_NamedNumberInputPreset_1.value = UnknownVarFromInNeighborhood_Point_1.x;
         }
         if(UnknownVarFromInNeighborhood_NamedNumberInputPreset_2 != null)
         {
            UnknownVarFromInNeighborhood_NamedNumberInputPreset_2.value = UnknownVarFromInNeighborhood_Point_1.y;
         }
      }
      
      private function setRootTileInternal(param1:int, param2:int, param3:Boolean) : void
      {
         if(UnknownVarFromInNeighborhood_Point_1 == null)
         {
            UnknownVarFromInNeighborhood_Point_1 = new Point(param1,param2);
         }
         else
         {
            UnknownVarFromInNeighborhood_Point_1.x = param1;
            UnknownVarFromInNeighborhood_Point_1.y = param2;
         }
         updateRootInputText();
         if(param3 && UnknownVarFromInNeighborhood_FloorDrawingPreset_1 != null)
         {
            UnknownVarFromInNeighborhood_FloorDrawingPreset_1.setRootTile(param1,param2);
         }
      }
      
      private function onRootXChanged(param1:int) : void
      {
         setRootTileInternal(param1,UnknownVarFromInNeighborhood_Point_1.y,true);
      }
      
      private function onRootYChanged(param1:int) : void
      {
         setRootTileInternal(UnknownVarFromInNeighborhood_Point_1.x,param1,true);
      }
      
      private function onRootTileChangedFromPreset(param1:int, param2:int) : void
      {
         setRootTileInternal(param1,param2,false);
      }
      
      private function toggleScreenSize() : void
      {
         _inBigMode = !_inBigMode;
         _preferBigMode = _inBigMode;
         _floor.smallMode = !_inBigMode;
         UnknownVarFromInNeighborhood_FloorDrawingPreset_1.setFloor(_floor);
         updateResolutionButtonUI();
         roomEventsCtrl.resizeFrame();
      }
      
      private function onDrawingChanged() : void
      {
         updateResolutionButtonUI();
      }
      
      override public function buildInputs(param1:PresetManager, param2:WiredStyle, param3:WiredUIBuilder) : void
      {
         var xyRow:SimpleListViewPreset;
         var createdButtons:Vector.<AssetButtonPreset>;
         var i:int;
         var list:SimpleListViewPreset;
         var section:SectionPreset;
         var presetManager:PresetManager = param1;
         var wiredStyle:WiredStyle = param2;
         var builder:WiredUIBuilder = param3;
         var buttonConfigs:Array = [new AssetButtonParam("add","",function():void
         {
            setMode(_drawModes[0]);
         }),new AssetButtonParam("remove","",function():void
         {
            setMode(_drawModes[1]);
         },true),new AssetButtonParam("reference","",function():void
         {
            setMode(_drawModes[2]);
         }),new AssetButtonParam("enlarge_image","",toggleScreenSize,false,true)];
         var buttonRow:AssetButtonRowPreset = presetManager.createAssetButtonRow(buttonConfigs);
         UnknownVarFromInNeighborhood_FloorDrawingPreset_1 = presetManager.createFloorDrawingPreset(onRootTileChangedFromPreset);
         UnknownVarFromInNeighborhood_FloorEditorPreset_1 = presetManager.createFloorEditorPreset(buttonRow,UnknownVarFromInNeighborhood_FloorDrawingPreset_1);
         UnknownVarFromInNeighborhood_AssetButtonPreset_1 = buttonRow.buttons[3];
         if(_floor != null)
         {
            UnknownVarFromInNeighborhood_FloorDrawingPreset_1.setFloor(_floor);
            UnknownVarFromInNeighborhood_FloorDrawingPreset_1.setRootTile(UnknownVarFromInNeighborhood_Point_1.x,UnknownVarFromInNeighborhood_Point_1.y);
            UnknownVarFromInNeighborhood_FloorDrawingPreset_1.setMode(_drawMode);
         }
         UnknownVarFromInNeighborhood_NamedNumberInputPreset_1 = presetManager.createNamedNumberInput(new NumberInputParam(0,-64,64,20),"x:");
         UnknownVarFromInNeighborhood_NamedNumberInputPreset_2 = presetManager.createNamedNumberInput(new NumberInputParam(0,-64,64,20),"y:");
         UnknownVarFromInNeighborhood_NamedNumberInputPreset_1.onValueChange = onRootXChanged;
         UnknownVarFromInNeighborhood_NamedNumberInputPreset_2.onValueChange = onRootYChanged;
         xyRow = presetManager.createSimpleListView(false,[UnknownVarFromInNeighborhood_NamedNumberInputPreset_1,UnknownVarFromInNeighborhood_NamedNumberInputPreset_2]);
         xyRow.spacing = wiredStyle.genericHorizontalSpacing;
         _drawButtonsByMode = {};
         createdButtons = buttonRow.buttons;
         i = 0;
         while(i < _drawModes.length && i < createdButtons.length)
         {
            _drawButtonsByMode[_drawModes[i]] = createdButtons[i];
            i++;
         }
         setMode(_drawMode);
         list = presetManager.createSimpleListView(true,[UnknownVarFromInNeighborhood_FloorEditorPreset_1,xyRow.alignRight()]);
         section = presetManager.createSection(l("neighborhood_selection"),list);
         builder.addElements(section);
      }
      
      override public function get widthModifier() : Number
      {
         if(_inBigMode)
         {
            return 1.7;
         }
         return 1;
      }
   }
}

