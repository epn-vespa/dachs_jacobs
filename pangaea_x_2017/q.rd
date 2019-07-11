<resource schema="pangaea_x_2017">
	<meta name="title">ESA PANGAEA-X 2017</meta>
	<meta name="description">Drone-based ohotogrammetric survey raw data from ESA PANGAEA-X 2017 planetary anlogue campaign - Data collected on 2017-11-19</meta>
	<meta name="creationDate">2017-12-22T06:56:00</meta>
	<meta name="subject">___</meta>
	<meta name="creator.name">Mikhail Minin</meta>
	<meta name="contact.name">Mikhail Minin</meta>
	<meta name="contact.email">m.minin@jacobs-university.de</meta>
	<meta name="instrument">Phantom 4 drone</meta>
        <meta name="subjects">Earth, drone</meta>
	<meta name="facility"></meta>
	<meta name="source"></meta>
	<meta name="contentLevel">Research</meta>
	<meta name="type">Catalog</meta>
	<meta name="coverage">
		<meta name="waveband">Optical</meta>
	</meta>

<!-- METADATA COMPLETE -->

	<table id="epn_core" onDisk="true">
		<mixin  spatial_frame_type="body" optional_columns="access_url thumbnail_url bib_reference">//epntap2#table-2_0</mixin>
		<meta name="info" infoName="SERVICE_PROTOCOL" infoValue="0.3">EPN-TAP</meta>
		<meta name="description">Drone-based ohotogrammetric survey raw data from ESA PANGAEA-X 2017 planetary anlogue campaign - Data collected on 2017-11-19</meta>
		<stc>
			Polygon UNKNOWNFrame [s_region]
		</stc>
                <index columns="s_region" method='GIST'/>
<!-- MAKE OPTIONAL COLUMNS: -->
		<column name="access_url" type="text" ucd="meta.ref.url;meta.file" verbLevel="1" description="URL of the data file, 
			case sensitive. If present, next 2 paramenters must be present."/> 
		<column name="thumbnail_url" type="text" ucd="meta.ref.url;meta.preview" verbLevel="1" description="URL of a thumbnail image with predefined size (png ~200 pix, for use in a client only)"/> 
                <column name="target_distance_min" type="double precision" unit="km" description="Observer-target distance" ucd="pos.distance;stat.min" />
                <column name="target_distance_max" type="double precision" unit="km" description="Observer-target distance" ucd="pos.distance;stat.max" />
<!-- MAKE ADDITIONAL COLUMNS: -->
                <column name="camera_yaw" type="double precision" unit="deg" description="Camera orientation" ucd="meta.note" />

		<publish sets="ivo_managed,local" />
	</table>
<!-- TABLE COMPLETE -->

	<data id="import">
		<sources>data/drone16.csv</sources>
		<csvGrammar>
			<rowfilter procDef="//products#define">
				<bind name="table">"schema.epn_core"</bind>
			</rowfilter>
		</csvGrammar>
		<make table="epn_core">
			<rowmaker idmaps="*">
				<var key="granule_uid" source="uid" />
				<var key="granule_gid" source="gid" />
				<var key="obs_id" source="obsid" />

				<var key="dataproduct_type">"catalog"</var>
				<var key="measurement_type">"photogrammetry"</var>

				<var key="processing_level">"2"</var>

				<var key="target_name">"Earth"</var>
				<var key="target_class">"planet"</var>

				<var key="time_min" source="TimeJD" />
				<var key="time_max" source="TimeJD" />
				<var key="time_exp_min" source="ExpTime" />
				<var key="time_exp_max" source="ExpTime" />


				<var key="c1min" source="GPSLonE" />
				<var key="c1max" source="GPSLonE" />

                                <var key="c1min">[@c1min,360+@c1min][@c1min &lt; 0]</var>
				<var key="c1max">[@c1max,360+@c1max][@c1max &lt; 0]</var>


				<var key="c2min" source="GPSLat" />
				<var key="c2max" source="GPSLat" />

<!--				<var key="c3min" source="GPSAlt" />
				<var key="c3max" source="GPSAlt" />-->

				<var key="target_distance_min" source="TargetDistance" />
				<var key="target_distance_max">@target_distance_min + 0.015</var>

<!--      <var key="s_region">pgsphere.SCircle(pgsphere.SPoint.fromDegrees(@c1min,@c2min),((math.tan((94.0/2.0)*math.pi/180)*@target_distance_max)/(math.pi*6371.0/180.0))*pgsphere.DEG).asPoly().asSTCS("UNKNOWNFrame")</var>-->
<!--      <var key="s_region">pgsphere.SCircle(pgsphere.SPoint.fromDegrees(@c1min,@c2min),(0.020/(math.pi*6371.0/180.0))*pgsphere.DEG).asPoly().asSTCS("UNKNOWNFrame")</var>-->
        <var key="s_region" source="footprint" />

<!--
<var key="measurement_type" source="footprint" />
<var key="s_region">pgsphere.SPoly([pgsphere.SPoint(float(q[0])*pgsphere.DEG,float(q[1])*pgsphere.DEG) for q in zip(@measurement_type.split(' ')[1::2],@measurement_type.split(' ')[2::2])])</var>
<var key="measurement_type">"photogrammetry"</var>

<var key="s_region">"Polygon -13.713648096078854 29.02067207570797 -13.713648290849653 29.02067463918934 -13.713648681721144 29.02067236829206 -13.713648486950346 29.0206698048107 -13.713648096078854 29.02067207570797"</var>
-->

				<var key="spatial_frame_type">"body"</var>





				<var key="instrument_host_name">"DJI Phantom 4"</var>


				<var key="access_url">"https://zenodo.org/record/1095400/files/"+@granule_uid+".JPG"</var>
				<var key="thumbnail_url">"https://zenodo.org/record/1095400/files/"+@granule_uid+"_browse.JPG"</var>


<var key="service_title">"Pangaea-X-2017"</var>
<var key="creation_date">"2017-12-22"</var>
<var key="modification_date">"2018-1-24"</var>
<var key="release_date">"2018-1-22"</var>





				<var key="bib_reference">"10.5281/zenodo.1095400"</var>

<var key="camera_yaw" source="CameraYaw" />

				<apply procDef="//epntap2#populate-2_0" name="fillepn">
					<bind name="granule_uid">@granule_uid</bind>
					<bind name="granule_gid">@granule_gid</bind>
					<bind name="obs_id">@obs_id</bind>

					<bind name="dataproduct_type">@dataproduct_type</bind>
					<bind name="measurement_type">@measurement_type</bind>

					<bind name="processing_level">@processing_level</bind>

					<bind name="target_name">@target_name</bind>
					<bind name="target_class">@target_class</bind>

					<bind name="time_min">@time_min</bind>
					<bind name="time_max">@time_max</bind>
					<bind name="time_exp_min">@time_exp_min</bind>
					<bind name="time_exp_max">@time_exp_max</bind>


					<bind name="c1min">@c1min</bind>
					<bind name="c1max">@c1max</bind>

					<bind name="c2min">@c2min</bind>
					<bind name="c2max">@c2max</bind>

					<bind name="c3min">@c3min</bind>
					<bind name="c3max">@c3max</bind>

<bind name="service_title">@service_title</bind>
<bind name="creation_date">@creation_date</bind>
<bind name="modification_date">@modification_date</bind>
<bind name="release_date">@release_date</bind>

<bind name="s_region">@s_region</bind>


					<bind name="instrument_host_name">@instrument_host_name</bind>


				</apply>
			</rowmaker>
		</make>
	</data>
</resource>
