import { useState } from "react";
import Navbar from "../../user/components/navbar";
import { login_user } from "../../api/api";
import { useNavigate } from "react-router-dom";

function Login() {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const navigate = useNavigate();

    const handleSubmit = async (e) => {
        e.preventDefault();
        try {
            const response = await login_user({ email, password });
            if (response.status === 200) {
                alert("Login successful!");
                navigate("/"); // example
            } else {
                alert("Login failed!");
            }
        } catch (error) {
            console.log("Error:", error);
        }
    };

    //     return (
    //         <>
    //             <Navbar />

    //             <section
    //                 className="min-h-screen bg-cover bg-center flex items-center justify-center"
    //                 style={{
    //                     backgroundImage:
    //                         "url('https://c4.wallpaperflare.com/wallpaper/334/190/550/the-inscription-sticker-minimal-wallpaper-preview.jpg')",
    //                 }}
    //             >
    //                 <div className="grid grid-cols-1 md:grid-cols-6 w-full max-w-4xl bg-white/80 rounded-lg overflow-hidden shadow-lg gap-4">

    //                     {/* LEFT IMAGE */}
    //                     <div className="hidden md:col-span-3 md:block">
    //                         <img
    //                             className="h-full w-full object-cover"
    //                             src="https://w0.peakpx.com/wallpaper/818/565/HD-wallpaper-notes-inscription-cubes-pencil-notebooks.jpg"
    //                             alt="notes"
    //                         />
    //                     </div>

    //                     {/* RIGHT FORM */}
    //                     <div className="col-span-1 md:col-span-3 p-6 grid place-content-center-safe">
    //                         <h1 className="text-xl font-bold mb-4">Login form</h1>

    //                         <form onSubmit={handleSubmit}>
    //                             <div className="my-2 ">
    //                                 <label>Email</label><br />
    //                                 <input
    //                                  className="border-1 border-slate-500 py-1 border-r-2 px-4"
    //                                     type="text"
    //                                     placeholder="Enter Email"
    //                                     value={email}
    //                                     onChange={(e) => setEmail(e.target.value)}
    //                                 />
    //                             </div>

    //                             <div className="my-2 "> 
    //                                 <label>Password</label><br />
    //                                 <input
    //                                     className="border-1 border-slate-500 py-1 border-r-2 px-4"
    //                                     type="password"
    //                                     placeholder="Enter Password"
    //                                     value={password}
    //                                     onChange={(e) => setPassword(e.target.value)}
    //                                 />
    //                             </div>

    //                             <button type="submit" className="bg-orange-500 my-2 px-4 text-white border-r-4 bg-sky-600 py-2 font-serif flex justify-center">
    //                                 Login
    //                             </button>
    //                         </form>
    //                     </div>
    //                 </div>
    //             </section>
    //         </>
    //     );
    // }

    // export default Login;



    return (
        <>
            <Navbar />

            <section
                className="min-h-screen bg-cover bg-center flex items-center justify-center px-4"
                style={{
                    backgroundImage:
                        "url('https://c4.wallpaperflare.com/wallpaper/334/190/550/the-inscription-sticker-minimal-wallpaper-preview.jpg')",
                }}
            >
                <div className="grid grid-cols-1 md:grid-cols-6 w-full max-w-4xl bg-white/80 rounded-lg overflow-hidden shadow-lg">

                    {/* LEFT IMAGE */}
                    <div className="hidden md:col-span-3 md:block">
                        <img
                            className="h-full w-full object-cover"
                            src="https://w0.peakpx.com/wallpaper/818/565/HD-wallpaper-notes-inscription-cubes-pencil-notebooks.jpg"
                            alt="notes"
                        />
                    </div>

                    {/* RIGHT FORM */}
                    <div className="col-span-1 md:col-span-3 flex items-center justify-center p-6">
                        {/* WRAPPER (important) */}
                        <div className="w-full max-w-sm">
                            <h1 className="text-2xl font-bold mb-6 text-center">
                                Login
                            </h1>

                            <form onSubmit={handleSubmit} className="space-y-4">
                                <div>
                                    <label className="block text-sm font-medium mb-1">
                                        Email
                                    </label>
                                    <input
                                        className="w-full border border-slate-400 px-4 py-2 rounded focus:outline-none focus:ring-2 focus:ring-sky-500"
                                        type="text"
                                        placeholder="Enter Email"
                                        value={email}
                                        onChange={(e) => setEmail(e.target.value)}
                                    />
                                </div>

                                <div>
                                    <label className="block text-sm font-medium mb-1">
                                        Password
                                    </label>
                                    <input
                                        className="w-full border border-slate-400 px-4 py-2 rounded focus:outline-none focus:ring-2 focus:ring-sky-500"
                                        type="password"
                                        placeholder="Enter Password"
                                        value={password}
                                        onChange={(e) => setPassword(e.target.value)}
                                    />
                                </div>

                                <button
                                    type="submit"
                                    className="w-full bg-sky-600 hover:bg-sky-700 transition text-white py-2 rounded font-semibold"
                                >
                                    Login
                                </button>
                            </form>
                        </div>
                    </div>

                </div>
            </section>
        </>
    );

}

export default Login;
