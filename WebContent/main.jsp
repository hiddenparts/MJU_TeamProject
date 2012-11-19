<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html lang="ko">
    <head>
    	<meta charset="utf-8">
	    <title>D_2조 팀프로젝트</title>
	    <script src="js/jquery-1.8.2.js"></script>
	    <link rel="stylesheet" type="text/css" href="css/main.css">
        <link rel="stylesheet" href="css/style.css">
    </head>

    <body>
        <jsp:include page="mainheader.jsp"/>

        <div id="menubar">
            메뉴바
        </div>

        <div id="list">
            <ul id="tiles">
            <!-- These are our grid blocks -->
                <li><img src="images/image_1.jpg"><p>1</p></li>
				<li><img src="images/image_2.jpg"><p>2</p></li>
				<li><img src="images/image_3.jpg"><p>3</p></li>
				<li><img src="images/image_4.jpg"><p>4</p></li>
				<li><img src="images/image_5.jpg"><p>5</p></li>
				<li><img src="images/image_6.jpg"><p>6</p></li>
				<li><img src="images/image_7.jpg"><p>7</p></li>
				<li><img src="images/image_8.jpg"><p>8</p></li>
				<li><img src="images/image_9.jpg"><p>9</p></li>
				<li><img src="images/image_10.jpg"><p>10</p></li>
				<li><img src="images/image_1.jpg"><p>11</p></li>
				<li><img src="images/image_2.jpg"><p>12</p></li>
				<li><img src="images/image_3.jpg"><p>13</p></li>
				<li><img src="images/image_4.jpg"><p>14</p></li>
				<li><img src="images/image_5.jpg"><p>15</p></li>
				<li><img src="images/image_6.jpg"><p>16</p></li>
				<li><img src="images/image_7.jpg"><p>17</p></li>
				<li><img src="images/image_8.jpg"><p>18</p></li>
				<li><img src="images/image_9.jpg"><p>19</p></li>
				<li><img src="images/image_10.jpg"><p>20</p></li>
				<li><img src="images/image_1.jpg"><p>21</p></li>
				<li><img src="images/image_2.jpg"><p>22</p></li>
				<li><img src="images/image_3.jpg"><p>23</p></li>
				<li><img src="images/image_4.jpg"><p>24</p></li>
				<li><img src="images/image_5.jpg"><p>25</p></li>
				<li><img src="images/image_6.jpg"><p>26</p></li>
				<li><img src="images/image_7.jpg"><p>27</p></li>
				<li><img src="images/image_8.jpg"><p>28</p></li>
				<li><img src="images/image_9.jpg"><p>29</p></li>
				<li><img src="images/image_10.jpg"><p>30</p></li>
				<li><img src="images/image_1.jpg"><p>31</p></li>
				<li><img src="images/image_2.jpg"><p>32</p></li>
				<li><img src="images/image_3.jpg"><p>33</p></li>
				<li><img src="images/image_4.jpg"><p>34</p></li>
				<li><img src="images/image_5.jpg"><p>35</p></li>
				<li><img src="images/image_6.jpg"><p>36</p></li>
				<li><img src="images/image_7.jpg"><p>37</p></li>
				<li><img src="images/image_8.jpg"><p>38</p></li>
				<li><img src="images/image_9.jpg"><p>39</p></li>
				<li><img src="images/image_10.jpg"><p>40</p></li>
				<li><img src="images/image_1.jpg"><p>41</p></li>
				<li><img src="images/image_2.jpg"><p>42</p></li>
				<li><img src="images/image_3.jpg"><p>43</p></li>
				<li><img src="images/image_4.jpg"><p>44</p></li>
				<li><img src="images/image_5.jpg"><p>45</p></li>
				<li><img src="images/image_6.jpg"><p>46</p></li>
				<li><img src="images/image_7.jpg"><p>47</p></li>
				<li><img src="images/image_8.jpg"><p>48</p></li>
				<li><img src="images/image_9.jpg"><p>49</p></li>
				<li><img src="images/image_10.jpg"><p>50</p></li>
				<li><img src="images/image_1.jpg"><p>51</p></li>
				<li><img src="images/image_2.jpg"><p>52</p></li>
				<li><img src="images/image_3.jpg"><p>53</p></li>
				<li><img src="images/image_4.jpg"><p>54</p></li>
				<li><img src="images/image_5.jpg"><p>55</p></li>
				<li><img src="images/image_6.jpg"><p>56</p></li>
				<li><img src="images/image_7.jpg"><p>57</p></li>
				<li><img src="images/image_8.jpg"><p>58</p></li>
				<li><img src="images/image_9.jpg"><p>59</p></li>
				<li><img src="images/image_10.jpg"><p>60</p></li>
				<li><img src="images/image_1.jpg"><p>61</p></li>
				<li><img src="images/image_2.jpg"><p>62</p></li>
				<li><img src="images/image_3.jpg"><p>63</p></li>
				<li><img src="images/image_4.jpg"><p>64</p></li>
				<li><img src="images/image_5.jpg"><p>65</p></li>
				<li><img src="images/image_6.jpg"><p>66</p></li>
				<li><img src="images/image_7.jpg"><p>67</p></li>
				<li><img src="images/image_8.jpg"><p>68</p></li>
				<li><img src="images/image_9.jpg"><p>69</p></li>
				<li><img src="images/image_10.jpg"><p>70</p></li>
            <!-- End of grid blocks -->
            </ul>

        </div>


    </body>

</html>

  <!-- Include the plug-in -->
  <script src="js/jquery.wookmark.js"></script>

  <!-- Include the imagesLoaded plug-in -->
  <script src="js/jquery.imagesloaded.js"></script>
  
  <!-- Once the page is loaded, initalize the plug-in. -->
  <script type="text/javascript">
    $('#tiles').imagesLoaded(function() {
      // Prepare layout options.
      var options = {
        autoResize: true, // This will auto-update the layout when the browser window is resized.
        container: $('#list'), // Optional, used for some extra CSS styling
        offset: 2, // Optional, the distance between grid items
        itemWidth: 210// Optional, the width of a grid item
      };
      
      // Get a reference to your grid items.
      var handler = $('#tiles li');
      
      // Call the layout function.
      handler.wookmark(options);
    });
    
  </script>
  
  