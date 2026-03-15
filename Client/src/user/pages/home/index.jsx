import { Link } from "react-router-dom";
import Navbar from "../../components/navbar";


function Home() {

    return (
        <>
            <Navbar />

            {/* Top section */}

            <section className="h-[500px] w-full 
bg-gradient-to-br from-slate-900 via-slate-800 to-slate-900
flex items-center justify-center
border border-slate-700">

                <div className="text-center px-6 max-w-3xl">

                    <h1 className="text-4xl md:text-5xl font-extrabold tracking-tight
    text-white mb-4">
                        My Personal Knowledge Notebook
                    </h1>

                    <p className="text-lg md:text-xl text-slate-300 leading-relaxed mb-6">
                        Notes on NodeJS, English, Flutter & more – clean, structured & free.
                    </p>

                    <button className="px-6 py-3 rounded-lg 
    bg-indigo-600 text-white font-semibold
    hover:bg-indigo-500 transition-all duration-300
    shadow-lg hover:shadow-indigo-500/40">
                        Explore Notes
                    </button>

                </div>
            </section>

            <section className="w-full py-20 bg-white">
                <div className="max-w-5xl mx-30 px-6">

                    <h2 className="text-2xl md:text-3xl font-semibold leading-relaxed text-left">

                        <span className="bg-gradient-to-r from-pink-500 to-red-500 
      bg-clip-text text-transparent font-bold">
                            “My Notes
                        </span>

                        <span className="text-slate-800">
                            &nbsp; is a personal digital notebook where topics are organized like books
                            and notes are written in clean, readable format.”
                        </span>

                    </h2>

                    <div>
                        {/* slide automatic topic image like every 2sec slide horizontal [ nodejs, css, english, flutter etc icon]  */}
                        <div>
                            <img src="" alt="" />
                        </div>
                    </div>

                </div>
            </section>
          
               




            <section className="w-full py-20 bg-slate-50">
                <div className="max-w-7xl mx-auto px-6">

                    {/* Section Heading */}
                    <h2 className="text-3xl font-bold text-slate-900 mb-8">
                        Topics Preview
                    </h2>

                    {/* Topic Categories */}
                    <div className="flex gap-6 mb-10 text-sm font-medium">
                        <button className="text-indigo-600 border-b-2 border-indigo-600 pb-1">
                            New Topics
                        </button>
                        <button className="text-slate-500 hover:text-slate-800 transition">
                            Old Topics
                        </button>
                        <button className="text-slate-500 hover:text-slate-800 transition">
                            Popular Topics
                        </button>
                    </div>

                    {/* Horizontal Scroll Topics */}
                    <div className="flex gap-6 overflow-x-auto scroll-smooth pb-4">

                        {/* Card */}
                        <div className="min-w-[260px] bg-white rounded-xl shadow-md 
      hover:shadow-xl transition-all duration-300">
                            <img
                                src="https://via.placeholder.com/300"
                                alt="NodeJS"
                                className="h-40 w-full object-cover rounded-t-xl"
                            />
                            <div className="p-5">
                                <h4 className="text-lg font-semibold text-slate-900">
                                    Node.js
                                </h4>
                                <p className="text-sm text-slate-600 mt-1">
                                    Backend development notes & APIs
                                </p>
                                <button className="mt-4 text-indigo-600 font-medium hover:underline">
                                    Read →
                                </button>
                            </div>
                        </div>

                        {/* Card */}
                        <div className="min-w-[260px] bg-white rounded-xl shadow-md 
      hover:shadow-xl transition-all duration-300">
                            <img
                                src="https://via.placeholder.com/300"
                                alt="Flutter"
                                className="h-40 w-full object-cover rounded-t-xl"
                            />
                            <div className="p-5">
                                <h4 className="text-lg font-semibold text-slate-900">
                                    Flutter
                                </h4>
                                <p className="text-sm text-slate-600 mt-1">
                                    Build beautiful mobile apps
                                </p>
                                <button className="mt-4 text-indigo-600 font-medium hover:underline">
                                    Read →
                                </button>
                            </div>
                        </div>

                        {/* Card */}
                        <div className="min-w-[260px] bg-white rounded-xl shadow-md 
      hover:shadow-xl transition-all duration-300">
                            <img
                                src="https://via.placeholder.com/300"
                                alt="English"
                                className="h-40 w-full object-cover rounded-t-xl"
                            />
                            <div className="p-5">
                                <h4 className="text-lg font-semibold text-slate-900">
                                    English
                                </h4>
                                <p className="text-sm text-slate-600 mt-1">
                                    Grammar, vocabulary & usage
                                </p>
                                <button className="mt-4 text-indigo-600 font-medium hover:underline">
                                    Read →
                                </button>
                            </div>
                        </div>

                    </div>

                    {/* View All Button */}
                    <div className="mt-10 text-center">
                        <button className="px-6 py-3 rounded-lg bg-indigo-600 text-white 
      font-semibold hover:bg-indigo-500 transition">
                            View All Topics
                        </button>
                    </div>

                </div>
            </section>


            <section className="w-full py-20 bg-white">
                <div className="max-w-6xl mx-auto px-6">

                    {/* Heading */}
                    <h2 className="text-3xl font-bold text-center text-slate-900 mb-12">
                        How It Works
                    </h2>

                    {/* Steps */}
                    <div className="grid grid-cols-1 md:grid-cols-3 gap-10 text-center">

                        {/* Step 1 */}
                        <div className="p-6">
                            <div className="w-16 h-16 mx-auto mb-4 rounded-full 
        bg-indigo-100 text-indigo-600 flex items-center justify-center text-2xl">
                                📚
                            </div>
                            <h3 className="text-lg font-semibold text-slate-900 mb-2">
                                Choose a Topic
                            </h3>
                            <p className="text-slate-600 text-sm">
                                Browse topics and select what you want to learn.
                            </p>
                        </div>

                        {/* Step 2 */}
                        <div className="p-6">
                            <div className="w-16 h-16 mx-auto mb-4 rounded-full 
        bg-indigo-100 text-indigo-600 flex items-center justify-center text-2xl">
                                📖
                            </div>
                            <h3 className="text-lg font-semibold text-slate-900 mb-2">
                                Open Notes
                            </h3>
                            <p className="text-slate-600 text-sm">
                                Open well-structured notes written in simple language.
                            </p>
                        </div>

                        {/* Step 3 */}
                        <div className="p-6">
                            <div className="w-16 h-16 mx-auto mb-4 rounded-full 
        bg-indigo-100 text-indigo-600 flex items-center justify-center text-2xl">
                                🚀
                            </div>
                            <h3 className="text-lg font-semibold text-slate-900 mb-2">
                                Read & Learn
                            </h3>
                            <p className="text-slate-600 text-sm">
                                Learn at your own pace and build strong understanding.
                            </p>
                        </div>

                    </div>

                </div>
            </section>



            <div>
                <h1 className="text-red-500">Home page</h1>
                <Link to={'/reg-form'}>Reg - Form</Link>
                <div>
                    <Link to={'/get-userData'}>Reg Data</Link>
                </div>
                <div>
                    <Link to={'/view-notes'}>Topics</Link>
                </div>
                <div>
                    <Link to={'/view-lession'}>Lession</Link>
                </div>
                <div>
                    <Link to={'/view-notes'}>Notes</Link>
                </div>
                <div>
                    <Link to={'/login'}>Login</Link>
                </div>
                <div>
                    <Link to={'/add-notes'}>Add Notes</Link>
                </div>
                                <div>
                    <Link to={'/all-notes'}>All Notes</Link>
                </div>
                
                <div>
                    <Link to={'/dashboard'} >Dashboard</Link>
                </div>

            </div>

            <section>
                <div className="h-[200px] w-full border-2 border-amber-500">
                    <h1>Image slider</h1>
                </div>
            </section>
            <section>
                <div className="h-[200px] w-full border-2 border-amber-500">
                    <h1>topic slider</h1>
                </div>
            </section>
        </>
    )
}

export default Home;